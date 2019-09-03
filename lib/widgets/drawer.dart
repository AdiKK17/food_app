import 'package:flutter/material.dart';

import '../pages/all_recipe_page.dart';
import '../pages/category_page.dart';
import '../pages/favorite_page.dart';
import '../pages/shopping_list_page.dart';
import '../pages/auth_page.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.only(right: 30, bottom: 20),
            color: Colors.cyanAccent,
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Welcome",
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            ),
            alignment: Alignment.bottomRight,
          ),
          ListTile(
            trailing: Icon(Icons.all_inclusive),
            title: Text(
              "Recipes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EveryRecipe(),
                ),
              );
            },
          ),
          ListTile(
              trailing: Icon(Icons.category),
              title: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowCategories(),
                  ),
                );
              }),
          ListTile(
              trailing: Icon(Icons.favorite),
              title: Text(
                "Favorites",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowFavorites(),
                  ),
                );
              }),
          ListTile(
              trailing: Icon(Icons.shopping_cart),
              title: Text(
                "Shopping List",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShoppingList(),
                  ),
                );
              }),
          Divider(),
          ListTile(
            title: Text(
              "LogOut",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthenticationPage())),
          )
        ],
      ),
    );
  }
}
