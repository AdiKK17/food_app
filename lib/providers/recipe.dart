import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/recipe1.dart';
import './auth.dart';

class Recipe with ChangeNotifier {
  List<Recipe1> _items = [];
  Map<String, dynamic> _favorites = {};
  List<dynamic> _favoritesRecipeId = [];
  List<Recipe1> _favoriteRecipes = [];
  List<Recipe1> _particularUserFavoriteRecipes = [];

  //getters

  List<Recipe1> get particularUserFavoriteRecipes{
    return List.from(_particularUserFavoriteRecipes);
  }

  List<Recipe1> get favoriteRecipes {
    return List.from(_favoriteRecipes);
  }

  List<Recipe1> get item {
    return List.from(_items);
  }

  //END OF GETTERS//

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("An error Occured!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }

  Future<void> fetchRecipes(BuildContext context) async {
//    const url = "https://www.food2fork.com/api/get?key=f7d92b58ec2e350119d5c25b5c491d04&rId=34370";

  final int randomPageNo =  int.parse(Random().nextInt(3000).toString());
    final url =
        "https://www.food2fork.com/api/search?key=83199ffb2f88427105f2c940218f5b70&page=$randomPageNo";
 try {

  final response = await http.get(url);
  final responseData = json.decode(response.body);

  if(responseData["error"] != null){
    _showErrorDialog(context, "Api calls Limit reached");
    return;
  }

  final List<Recipe1> recipe = [];
  for (int i = 0; i < responseData["count"]; i++) {
    String imageUrl = responseData["recipes"][i]["image_url"];
    String title = responseData["recipes"][i]["title"];
    String rating = responseData["recipes"][i]["social_rank"].toString();
    String id = responseData["recipes"][i]["recipe_id"].toString();
    String sourceUrl = responseData["recipes"][i]["source_url"];

    recipe.add(Recipe1(
        title: title,
        imageUrl: imageUrl,
        rating: rating,
        id: id,
        detailSource: sourceUrl));
  }

  _items = recipe;
  notifyListeners();
   }catch(error){
   var errorMessage = "Could not fetch Data! Check your internet connection and try again later";
   print(errorMessage);
   _showErrorDialog(context,errorMessage);
     }
  }

  Future<void> favoriteIt(BuildContext context ,String title, String imageUrl, String rating,
      String recipeId, String sourceUrl) async {
    final url = "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favorites.json";
    final anotherUrl =
        "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes.json";

//    await fetchFavorites();

    if (!_favorites.containsValue(recipeId)) {
      await http.post(url, body: json.encode((recipeId)));
      await http.post(
        anotherUrl,
        body: json.encode(
          {
            "title": title,
            "imageUrl": imageUrl,
            "rating": rating,
            "id": recipeId,
            "detailSource": sourceUrl
          },
        ),
      );
      await fetchFavorites(context);
    }
  }

  Future<void> fetchFavorites(BuildContext context) async {
    final url = "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favorites.json";
    final response = await http.get(url);
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

    _favorites.addAll(extractedData);
    _favoritesRecipeId = _favorites.keys.toList();

    notifyListeners();
  }

  Future<void> deFavoriteIt(BuildContext context, int index) async {
    await fetchFavorites(context);

    final favoriteRecipesId = _favoriteRecipes[index].firebaseId;
    final favoritesId = _favoritesRecipeId[index];

    final url = "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes/$favoriteRecipesId.json";
    final anotherUrl = "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favorites/$favoritesId.json";


    _favoriteRecipes.removeAt(index);
    _favoritesRecipeId.removeAt(index);

    await http.delete(url);
    await http.delete(anotherUrl);
    notifyListeners();
  }

//  Future<void> createFavoriteList() async {
//    final List<Recipe1> temporaryFavorite = [];
//
//    for (var i = 0; i < _favoritesRecipeId.length; i++) {
//      final url =
//          "https://www.food2fork.com/api/get?key=8e2b691aa3b937b208975c6f081b0792&rId=${_favoritesRecipeId[i]}";
//      print(url);
//      final response = await http.get(url);
//      final extractedData = json.decode(response.body);
//
//      print(extractedData);
//      print("hello");
//
//      String imageUrl = extractedData["recipe"]["image_url"];
//      String title = extractedData["recipe"]["title"];
//      String rating = extractedData["recipe"]["social_rank"].toString();
//      String id = extractedData["recipe"]["recipe_id"].toString();
//      String sourceUrl = extractedData["recipe"]["source_url"];
//
//      temporaryFavorite.add(Recipe1(
//          title: title,
//          imageUrl: imageUrl,
//          rating: rating,
//          id: id,
//          detailSource: sourceUrl));
//    }
//    _favoriteRecipes = temporaryFavorite;
//    print(_favoriteRecipes[0]);
//    notifyListeners();
//  }

  Future<void> createFavoriteList(BuildContext context) async {
    final url = "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes.json";
    final responseData = await http.get(url);
    final extractedData =
        json.decode(responseData.body) as Map<String, dynamic>;


    if(extractedData == null){
      return;
    }

    final List<Recipe1> temporaryFavorite = [];
    extractedData.forEach(
      (fireId, recipeData) {
        temporaryFavorite.add(
          Recipe1(
            firebaseId: fireId,
            title: recipeData["title"],
            imageUrl: recipeData["imageUrl"],
            rating: recipeData["rating"],
            id: recipeData["id"],
            detailSource: recipeData["detailSource"],
          ),
        );
      },
    );
    _favoriteRecipes = temporaryFavorite;
    notifyListeners();
  }

  //testing


  Future<void> createParticularUserFavoriteList(BuildContext context,String fireId) async {
    final url = "https://recipedia-58d9b.firebaseio.com/$fireId/favoriteRecipes.json";
    final responseData = await http.get(url);
    final extractedData =
    json.decode(responseData.body) as Map<String, dynamic>;


    if(extractedData == null){
      _particularUserFavoriteRecipes.clear();
      return;
    }

    final List<Recipe1> temporaryFavorite = [];
    extractedData.forEach(
          (fireId, recipeData) {
        temporaryFavorite.add(
          Recipe1(
            firebaseId: fireId,
            title: recipeData["title"],
            imageUrl: recipeData["imageUrl"],
            rating: recipeData["rating"],
            id: recipeData["id"],
            detailSource: recipeData["detailSource"],
          ),
        );
      },
    );
    _particularUserFavoriteRecipes = temporaryFavorite;
    notifyListeners();
  }


}
