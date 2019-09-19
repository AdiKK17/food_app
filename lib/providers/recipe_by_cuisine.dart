import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/recipe1.dart';

class RecipeByCuisine extends ChangeNotifier{

  List<Recipe1> _cuisineList = [];

  List<Recipe1> get cuisineList {
    return List.from(_cuisineList);
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


  Future<void> fetchRecipes(BuildContext context,String title) async {
//    const url = "https://www.food2fork.com/api/get?key=f7d92b58ec2e350119d5c25b5c491d04&rId=34370";
    final url =
        "https://www.food2fork.com/api/search?key=f7d92b58ec2e350119d5c25b5c491d04&q=$title";
//    8b2a51f6f5884208ad88c8d478813cab
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


}