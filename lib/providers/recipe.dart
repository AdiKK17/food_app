import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/recipe1.dart';
import './auth.dart';

class Recipe with ChangeNotifier {
  List<Recipe1> _items = [];
  List<Recipe1> _favoriteRecipes = [];
  List<Recipe1> _particularUserFavoriteRecipes = [];

  //getters

  List<Recipe1> get particularUserFavoriteRecipes {
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
    final int randomPageNo = int.parse(Random().nextInt(3000).toString());
    final url =
        "https://www.food2fork.com/api/search?key=8b2a51f6f5884208ad88c8d478813cab&page=$randomPageNo";
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData["error"] != null) {
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
    } catch (error) {
      var errorMessage =
          "Could not fetch Data! Check your internet connection and try again later";
      print(errorMessage);
      _showErrorDialog(context, errorMessage);
    }
  }

  //Favoriting Feature

  void toggleFavoriteStatus(int index) {
    final currentFavoriteStatus = _items[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;

    final Recipe1 updatedRecipe = Recipe1(
        title: _items[index].title,
        imageUrl: _items[index].imageUrl,
        rating: _items[index].rating,
        id: _items[index].id,
        detailSource: _items[index].detailSource,
        isFavorite: newFavoriteStatus);

    _items[index] = updatedRecipe;
    notifyListeners();
  }

  Future<void> favoriteIt(BuildContext context, String title, String imageUrl,
      String rating, String recipeId, String sourceUrl) async {
    final anotherUrl =
        "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes/$recipeId.json";

    await http.put(
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
  }

  Future<void> deFavoriteIt(BuildContext context, int index) async {
    final favoriteRecipesId = _favoriteRecipes[index].id;
    final url =
        "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes/$favoriteRecipesId.json";
    _favoriteRecipes.removeAt(index);
    notifyListeners();

    await http.delete(url);
  }

  Future<void> createFavoriteList(BuildContext context) async {
    final url =
        "https://recipedia-58d9b.firebaseio.com/${Provider.of<Auth>(context).userId}/favoriteRecipes.json";
    final responseData = await http.get(url);
    final extractedData =
        json.decode(responseData.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Recipe1> temporaryFavorite = [];
    extractedData.forEach(
      (id, recipeData) {
        temporaryFavorite.add(
          Recipe1(
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

  Future<void> createParticularUserFavoriteList(
      BuildContext context, String fireId) async {
    final url =
        "https://recipedia-58d9b.firebaseio.com/$fireId/favoriteRecipes.json";
    final responseData = await http.get(url);
    final extractedData =
        json.decode(responseData.body) as Map<String, dynamic>;

    if (extractedData == null) {
      _particularUserFavoriteRecipes.clear();
      return;
    }

    final List<Recipe1> temporaryFavorite = [];
    extractedData.forEach(
      (id, recipeData) {
        temporaryFavorite.add(
          Recipe1(
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

//FAVORITING FEATURE ENDS//

}
