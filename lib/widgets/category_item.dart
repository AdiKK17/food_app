import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  final String id;
  final String title;

  CategoryItem(this.id,this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 300,
      width: double.infinity,
      child: Card(
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
