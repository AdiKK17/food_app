import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/recipe1.dart';

class Recipe with ChangeNotifier{
  
  List<Recipe1> _items = [];
  
  List<Recipe1> get item{
    return List.from(_items);
  }
  
  Future<void> fetchRecipe() async {

//    const url = "https://www.food2fork.com/api/get?key=f7d92b58ec2e350119d5c25b5c491d04&rId=34370";
    const url = "https://www.food2fork.com/api/search?key=6e932845f4b874be73b217617ab07bfe";


    final response = await http.get(url);
    final responseData = json.decode(response.body);
    
//    print(responseData["recipes"][0]);
//    print("it might be working");
//    print(responseData["recipes"][1]);



    final List<Recipe1> recipe = [];

     for(int i=0;i<30;i++){

       String imageUrl = responseData["recipes"][i]["image_url"];
       String title = responseData["recipes"][i]["title"];
       String rating = responseData["recipes"][i]["social_rank"].toString();
       String id = responseData["recipes"][i]["recipe_id"].toString();
       String sourceUrl = responseData["recipes"][i]["source_url"];

        recipe.add(Recipe1(title: title, imageUrl: imageUrl, rating: rating, id: id, detailSource: sourceUrl));

     }
  print(recipe.length);

     _items = recipe;
     notifyListeners();


  }

}

