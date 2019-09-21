import 'package:flutter/material.dart';
import 'package:async/async.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/shopping_list.dart';

class ShoppingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShoppingList();
  }
}

class _ShoppingList extends State<ShoppingList> {
  final GlobalKey<FormState> _ingredientKey = GlobalKey<FormState>();

  String _item;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Widget buildIngredientsTextFields() {
    return TextFormField(
      autofocus: true,
      maxLines: 2,
      decoration: InputDecoration(
        hintText: "Add an item",
      ),
      onSaved: (String value) {
        _item = value;
      },
    );
  }

  void submitItem() {
    _ingredientKey.currentState.save();

    if (_item.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    Provider.of<ShoppingIngredients>(context).addItem(
        _item, Provider.of<ShoppingIngredients>(context).itemsToShop.length);

    Fluttertoast.showToast(
        msg: "Item Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Things to buy"),
        backgroundColor: Color.fromRGBO(20, 89, 29, 1),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(225, 226, 137, 1),
        child: Icon(Icons.add),
        onPressed: () {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Form(
                  key: _ingredientKey,
                  child: AlertDialog(
                    content: Container(
                      height: 190,
                      width: 300,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          buildIngredientsTextFields(),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              FlatButton(
                                onPressed: () => submitItem(),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      body: FutureBuilder(
        future: _memoizer.runOnce(() async {
          await Provider.of<ShoppingIngredients>(context).fetchAndSet();
          print(Provider.of<ShoppingIngredients>(context).itemsToShop.length);
          print("dash0");
        }),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Provider.of<ShoppingIngredients>(context).itemsToShop.length == 0
                ? Center(
                    child: Text(
                      "-_-  Nothing to buy  -_-",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                                size: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Remove",
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                        ),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          Provider.of<ShoppingIngredients>(context).deleteItem(
                              Provider.of<ShoppingIngredients>(context)
                                  .itemsToShop[index]
                                  .id,
                              index);
                        },
                        key: ValueKey(Provider.of<ShoppingIngredients>(context)
                            .itemsToShop[index]
                            .id),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          height: 80,
//                          constraints:
//                              BoxConstraints(minHeight: 80, maxHeight: 500),
                          width: double.infinity,
                          child: Card(
                            elevation: 7,
                            color: Color.fromRGBO(153, 170, 56, 1),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  color: Color.fromRGBO(153, 170, 56, 1),
                                  child: Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                               Flexible(child: Container(
                                  child: Text(
                                    Provider.of<ShoppingIngredients>(context)
                                        .itemsToShop[index]
                                        .description, //use wrap here
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                               ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: Provider.of<ShoppingIngredients>(context)
                        .itemsToShop
                        .length,
                  ),
      ),
    );
  }
}
