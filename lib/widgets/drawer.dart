import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../pages/favorite_page.dart';
import '../pages/shopping_list_page.dart';
import '../pages/cuisine_page.dart';
import '../providers/auth.dart';
import '../main.dart';
import '../pages/user_interaction/profile_page.dart';
import '../pages/user_interaction/friends_page.dart';
import '../pages/user_interaction/notifications_page.dart';
import '../pages/category_page1.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 5,
      child: Container(
        color: Colors.black12,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/newDrawerImage.jpg"),
                    fit: BoxFit.cover),
              ),
              padding: EdgeInsets.only(right: 30, bottom: 20),
              margin: EdgeInsets.only(top: 30),
              child: Text(
                Provider.of<Auth>(context).userData["name"] == null ? "" : Provider.of<Auth>(context).userData["name"],
                style: TextStyle(fontSize: 30, fontFamily: "Oswald"),
              ),
              alignment: Alignment.bottomRight,
            ),
            ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryPage1(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.category),
                title: Text(
                  "Cuisines",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CuisinePage(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                  "Favorites",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowFavorites(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(
                  "Shopping List",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
              leading: Icon(Icons.person_outline),
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
                leading: Icon(Icons.group_add),
                title: Text(
                  "Add Friends",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
                leading: Icon(Icons.notifications),
                title: Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
