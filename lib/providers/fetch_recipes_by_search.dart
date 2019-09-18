import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/recipe1.dart';

class SearchedRecipes with ChangeNotifier {
  List<Recipe1> _searchedItems = [];

  //getters


  List<Recipe1> get searchedItems {
    return List.from(_searchedItems);
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

  Future<void> fetchSearchedRecipes(BuildContext context,String query) async {

    _searchedItems.clear();

    try{
    final url =
        "https://www.food2fork.com/api/search?key=dc56c1573a8df1aa30d1eadd1d428a63&q=$query";

    final response = await http.get(url);
    final responseData = json.decode(response.body);

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

    print("dash");
    print("hahs");


    _searchedItems = recipe;
    notifyListeners();
    }catch(error){
      var errorMessage = "Could not fetch Data! Try again later";
      print(errorMessage);
      _showErrorDialog(context,errorMessage);
    }
  }
}