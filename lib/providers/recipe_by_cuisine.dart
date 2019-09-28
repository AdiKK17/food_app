import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/recipe1.dart';

class RecipeByCuisine extends ChangeNotifier{

  List<Recipe1> _cuisineList1 = [];
  List<Recipe1> _cuisineList2 = [];
  List<Recipe1> _cuisineList3 = [];
  List<Recipe1> _cuisineList4 = [];
  List<Recipe1> _cuisineList = [];


  List<Recipe1> get cuisineList {
    return List.from(_cuisineList);
  }

  List<Recipe1> get cuisineList1 {
    return List.from(_cuisineList1);
  }

  List<Recipe1> get cuisineList2 {
    return List.from(_cuisineList2);
  }

  List<Recipe1> get cuisineList3 {
    return List.from(_cuisineList3);
  }

  List<Recipe1> get cuisineList4 {
    return List.from(_cuisineList4);
  }


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


  Future<void> fetchRecipes1(BuildContext context,String title) async {
    final url =
        "https://www.food2fork.com/api/search?key=a6ed66e1903973bce080455718e260b3&q=$title";
  try {
    final response = await http.get(url);
    final responseData = json.decode(response.body);

    if(responseData["error"] != null){
      _showErrorDialog(context, "Api calls Limit reached");
      return;
    }
    print(responseData);

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

    _cuisineList1 = recipe;
    notifyListeners();
    }
    catch(error){
    var errorMessage = "Could not fetch the data! Check your internet connection and try again later";
    _showErrorDialog(context,errorMessage);
   }

  }


  Future<void> fetchRecipes2(BuildContext context,String title) async {
    final url =
        "https://www.food2fork.com/api/search?key=d8f7fad2f2e5516f85671a5c3914b2ce&q=$title";
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if(responseData["error"] != null){
        _showErrorDialog(context, "Api calls Limit reached");
        return;
      }
      print(responseData);

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

      _cuisineList2 = recipe;
      notifyListeners();
    }
    catch(error){
      var errorMessage = "Could not fetch the data! Check your internet connection and try again later";
      _showErrorDialog(context,errorMessage);
    }

  }

  Future<void> fetchRecipes3(BuildContext context,String title) async {
    final url =
        "https://www.food2fork.com/api/search?key=a9aa144f16bedd4447d53c239da4265e&q=$title";
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if(responseData["error"] != null){
        _showErrorDialog(context, "Api calls Limit reached");
        return;
      }
      print(responseData);

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

      _cuisineList3 = recipe;
      notifyListeners();
    }
    catch(error){
      var errorMessage = "Could not fetch the data! Check your internet connection and try again later";
      _showErrorDialog(context,errorMessage);
    }

  }


  Future<void> fetchRecipes4(BuildContext context,String title) async {
    final url =
        "https://www.food2fork.com/api/search?key=e928ed54cbc8139083b74afbb368397d&q=$title";
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if(responseData["error"] != null){
        _showErrorDialog(context, "Api calls Limit reached");
        return;
      }
      print(responseData);

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

      _cuisineList4 = recipe;
      notifyListeners();
    }
    catch(error){
      var errorMessage = "Could not fetch the data! Check your internet connection and try again later";
      _showErrorDialog(context,errorMessage);
    }

  }



  Future<void> fetchRecipes(BuildContext context,String title) async {

    final int randomPageNo = int.parse(Random().nextInt(5).toString());

    final url =
        "https://www.food2fork.com/api/search?key=6e932845f4b874be73b217617ab07bfe&q=$title&page=$randomPageNo";
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if(responseData["error"] != null){
        _showErrorDialog(context, "Api calls Limit reached");
        return;
      }
      print(responseData);

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

      _cuisineList = recipe;
      notifyListeners();
    }
    catch(error){
      var errorMessage = "Could not fetch the data! Check your internet connection and try again later";
      _showErrorDialog(context,errorMessage);
    }

  }



  void toggleCuisineFavoriteStatus(int index) {
//    print("_cuisineList$listNum[$index].title");
    final currentFavoriteStatus = _cuisineList[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;

    final Recipe1 updatedRecipe = Recipe1(
        title: _cuisineList[index].title,
        imageUrl: _cuisineList[index].imageUrl,
        rating: _cuisineList[index].rating,
        id: _cuisineList[index].id,
        detailSource: _cuisineList[index].detailSource,
        isFavorite: newFavoriteStatus);

    _cuisineList[index] = updatedRecipe;
    notifyListeners();
  }



  void toggleCuisineFavoriteStatus1(int index) {
    final currentFavoriteStatus = _cuisineList1[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;
    final Recipe1 updatedRecipe = Recipe1(
        title: _cuisineList1[index].title,
        imageUrl: _cuisineList1[index].imageUrl,
        rating: _cuisineList1[index].rating,
        id: _cuisineList1[index].id,
        detailSource: _cuisineList1[index].detailSource,
        isFavorite: newFavoriteStatus);

    _cuisineList1[index] = updatedRecipe;
    notifyListeners();
  }

  void toggleCuisineFavoriteStatus2(int index) {
    final currentFavoriteStatus = _cuisineList2[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;
    final Recipe1 updatedRecipe = Recipe1(
        title: _cuisineList2[index].title,
        imageUrl: _cuisineList2[index].imageUrl,
        rating: _cuisineList2[index].rating,
        id: _cuisineList2[index].id,
        detailSource: _cuisineList2[index].detailSource,
        isFavorite: newFavoriteStatus);

    _cuisineList2[index] = updatedRecipe;
    notifyListeners();
  }

  void toggleCuisineFavoriteStatus3(int index) {
    final currentFavoriteStatus = _cuisineList3[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;
    final Recipe1 updatedRecipe = Recipe1(
        title: _cuisineList3[index].title,
        imageUrl: _cuisineList3[index].imageUrl,
        rating: _cuisineList3[index].rating,
        id: _cuisineList3[index].id,
        detailSource: _cuisineList3[index].detailSource,
        isFavorite: newFavoriteStatus);

    _cuisineList3[index] = updatedRecipe;
    notifyListeners();
  }

  void toggleCuisineFavoriteStatus4(int index) {
    final currentFavoriteStatus = _cuisineList4[index].isFavorite;
    final newFavoriteStatus = !currentFavoriteStatus;
    final Recipe1 updatedRecipe = Recipe1(
        title: _cuisineList4[index].title,
        imageUrl: _cuisineList4[index].imageUrl,
        rating: _cuisineList4[index].rating,
        id: _cuisineList4[index].id,
        detailSource: _cuisineList4[index].detailSource,
        isFavorite: newFavoriteStatus);

    _cuisineList4[index] = updatedRecipe;
    notifyListeners();
  }


}