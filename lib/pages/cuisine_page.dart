import 'package:flutter/material.dart';

import '../widgets/cuisine_item.dart';
import '../training.dart';

class CuisinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuisines"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(color: Colors.teal,child: GridView.builder(
        itemCount: DUMMY_CATEGORIES.length,
        itemBuilder: (context, index) => CuisineItem(
            DUMMY_CATEGORIES[index].title,DUMMY_CATEGORIES[index].imageUrl),
        padding: EdgeInsets.all(2.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12),
      ),
    ),);
  }
}
