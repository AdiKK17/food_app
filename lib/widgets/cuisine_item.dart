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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Stack(
          children: <Widget>[
             Center(
              child:Container(
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
//                  borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                fontFamily: "Nexa"),
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
