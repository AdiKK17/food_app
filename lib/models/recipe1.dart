import 'package:flutter/material.dart';

class Recipe1 {

//  final String firebaseId;
  final String title;
  final String imageUrl;
  final String rating;
  final String id;
  final String detailSource;
  final bool isFavorite;
  Recipe1({@required this.title, @required this.imageUrl, @required this.rating,@required this.id,@required this.detailSource,this.isFavorite = false});

}