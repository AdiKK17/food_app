import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../pages/category_page.dart';
import '../pages/favorite_page.dart';
import '../pages/shopping_list_page.dart';
import '../pages/cuisine_page.dart';
import '../providers/auth.dart';
import '../main.dart';
import '../pages/user_interaction/profile_page.dart';
import '../pages/user_interaction/friends_page.dart';
import '../pages/user_interaction/notifications_page.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 5,
      child: Container(
        color: Colors.black12,
//        color: Color.fromRGBO(150, 200, 106, 1),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/authImage.jpg"),
                    fit: BoxFit.cover),
              ),
              padding: EdgeInsets.only(right: 30, bottom: 20),
//              color: Colors.cyanAccent,
              margin: EdgeInsets.only(top: 30),
              child: Text(
                Provider.of<Auth>(context).userEmail == null
                    ? "holo"
                    : Provider.of<Auth>(context).userEmail,
                style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic),
              ),
              alignment: Alignment.bottomRight,
            ),
//          ListTile(
//            trailing: Icon(Icons.all_inclusive),
//            title: Text(
//              "Recipes",
//              style: TextStyle(fontWeight: FontWeight.bold),
//            ),
//            onTap: () {
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (context) => EveryRecipe(),
//                ),
//              );
//            },
//          ),
            ListTile(
                trailing: Icon(Icons.timelapse),
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
                trailing: Icon(Icons.category),
                title: Text(
                  "Cuisines",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CuisinePage(),
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
              trailing: Icon(Icons.person_outline),
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Provider.of<Auth>(context).fetchUserDetails();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
                trailing: Icon(Icons.group_add),
                title: Text(
                  "Add Friends",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
//                Provider.of<Auth>(context).fetchAllUsersData();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FriendsPage(),
                    ),
                  );
                }),
            ListTile(
                trailing: Icon(Icons.notifications),
                title: Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
//                Provider.of<Auth>(context).fetchAllUsersData();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(),
                    ),
                  );
                }),
            Divider(),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyFoodApp(),
                  ),
                );
                Provider.of<Auth>(context, listen: false).logout();
              },
            )
          ],
        ),
      ),
    ),);
  }
}
