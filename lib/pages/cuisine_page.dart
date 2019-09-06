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
      ),
      body: GridView.builder(
        itemCount: DUMMY_CATEGORIES.length,
        itemBuilder: (context, index) => CuisineItem(DUMMY_CATEGORIES[index].id,
            DUMMY_CATEGORIES[index].title, DUMMY_CATEGORIES[index].color),
        padding: EdgeInsets.all(1.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12),
      ),
    );
  }
}
