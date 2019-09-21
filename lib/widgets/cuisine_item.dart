import 'package:flutter/material.dart';

import '../pages/cuisines/cuisine_recipes_page.dart';

class CuisineItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  CuisineItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 190,
                height: 315,
                foregroundDecoration: BoxDecoration(color: Colors.black38),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                fontFamily: "Oswald"),
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CuisineRecipesPage(title))),
    );
  }
}
