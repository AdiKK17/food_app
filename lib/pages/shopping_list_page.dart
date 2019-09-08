import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/shopping_list.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Things to buy"),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        child: Icon(Icons.add),
        onPressed: () {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    height: 190,
                    width: 300,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          maxLines: 2,
                          decoration: InputDecoration(hintText: "Enter item"),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return;
        },
        itemCount: Provider.of<ShoppingIngredients>(context).itemsToBuy.length,
      ),
    );
  }
}
