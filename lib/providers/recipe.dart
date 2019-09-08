import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/recipe1.dart';

class Recipe with ChangeNotifier{
  
  List<Recipe1> _items = [];
  Map<String,dynamic> _favorites = {};
  List<dynamic> _favoritesRecipeId = [];
  List<Recipe1> _favoriteRecipes = [];


  //getters

  List<Recipe1> get favoriteRecipes{
    return List.from(_favoriteRecipes);
}

  List<Recipe1> get item{
    return List.from(_items);
  }




  Future<void> fetchRecipes() async {

//    const url = "https://www.food2fork.com/api/get?key=f7d92b58ec2e350119d5c25b5c491d04&rId=34370";
    const url = "https://www.food2fork.com/api/search?key=5b0c8bee914f431511fc53144ec3deac";

    final response = await http.get(url);
    final responseData = json.decode(response.body);

    final List<Recipe1> recipe = [];
     for(int i=0;i<30;i++){

       String imageUrl = responseData["recipes"][i]["image_url"];
       String title = responseData["recipes"][i]["title"];
       String rating = responseData["recipes"][i]["social_rank"].toString();
       String id = responseData["recipes"][i]["recipe_id"].toString();
       String sourceUrl = responseData["recipes"][i]["source_url"];

        recipe.add(Recipe1(title: title, imageUrl: imageUrl, rating: rating, id: id, detailSource: sourceUrl));
     }

     _items = recipe;
     notifyListeners();

  }



  Future<void> favoriteIt(String recipeId) async {
    const url = "https://recipedia-58d9b.firebaseio.com/favorites.json";
    await fetchFavorites();
    if(!_favorites.containsValue(recipeId)){
      await http.post(url,body: json.encode((recipeId)));
      await fetchFavorites();
    }
  }

  Future<void> fetchFavorites() async {
    const url = "https://recipedia-58d9b.firebaseio.com/favorites.json";
    final response =  await http.get(url);
    final extractedData = jsonDecode(response.body) as Map<String,dynamic> ;
    _favorites.addAll(extractedData);
    print(extractedData);
    print("exactly the same");
    print(_favorites);
    _favoritesRecipeId = _favorites.values.toList();
    print(_favoritesRecipeId);
    await createFavoriteList();
    print(favoriteRecipes.length);
    notifyListeners();
  }

  Future<void> deFavoriteIt(String recipeId) async {
    const url = "https://recipedia-58d9b.firebaseio.com/favorites.json";
    await http.delete(url);
  }


  Future<void> createFavoriteList() async {

    final List<Recipe1> temporaryFavorite = [];

    for(var i=0;i<_favoritesRecipeId.length;i++) {

      final url = "https://www.food2fork.com/api/get?key=5b0c8bee914f431511fc53144ec3deac&rId=${_favoritesRecipeId[i]}";
      print(url);
      final response = await http.get(url);
      final extractedData = json.decode(response.body);

    print(extractedData);
    print("hello");

      String imageUrl = extractedData["recipe"]["image_url"];
      String title = extractedData["recipe"]["title"];
      String rating = extractedData["recipe"]["social_rank"].toString();
      String id = extractedData["recipe"]["recipe_id"].toString();
      String sourceUrl = extractedData["recipe"]["source_url"];

      temporaryFavorite.add(Recipe1(title: title, imageUrl: imageUrl, rating: rating, id: id, detailSource: sourceUrl));


    }
    _favoriteRecipes = temporaryFavorite;
    print(_favoriteRecipes[0]);
    notifyListeners();

  }


}

