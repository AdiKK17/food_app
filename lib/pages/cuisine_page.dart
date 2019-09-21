import 'package:flutter/material.dart';

import '../widgets/cuisine_item.dart';
import '../training.dart';

class CuisinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Cuisines",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(20,89 , 29, 1),
      ),
      body: Container(
        color: Colors.black,
        child: GridView.builder(
          itemCount: DUMMY_CATEGORIES.length,
          itemBuilder: (context, index) => CuisineItem(
              DUMMY_CATEGORIES[index].title, DUMMY_CATEGORIES[index].imageUrl),
          padding: EdgeInsets.all(2.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 11),
        ),
      ),
    );
  }
}
