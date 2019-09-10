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

  Future<void> fetchSearchedRecipes(String query) async {
    final url =
        "https://www.food2fork.com/api/search?key=5b0c8bee914f431511fc53144ec3deac&q=$query";

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

    _searchedItems = recipe;
    notifyListeners();
  }
}