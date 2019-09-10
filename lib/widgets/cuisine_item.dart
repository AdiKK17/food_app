import 'package:flutter/material.dart';

import '../pages/cuisines/cuisine_recipes_page.dart';

class CuisineItem extends StatelessWidget {

//  final List<Widget> cuisinePages = [ChineseCuisinePage()];

  final String title;
  final String id;
  final String imageUrl;

  CuisineItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: GridTile(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CuisineRecipesPage(title))),
    );
  }
}
