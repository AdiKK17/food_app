import 'package:flutter/material.dart';

class CuisineItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CuisineItem(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: GridTile(
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
          fit: BoxFit.contain,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          title: Text(
            "Mediterrainian",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
