import 'package:flutter/material.dart';

import './categories/breakfast_page.dart';
import './categories/lunch_page.dart';
import './categories/snack_page.dart';
import './categories/dinner_page.dart';

class ShowCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("BreakFast"),
              ),
              Tab(
                child: Text("Lunch"),
              ),
              Tab(
                child: Text("Snacks"),
              ),
              Tab(
                child: Text("Dinner"),
              )
            ],
          ),
        ),
        body: TabBarView(children: [BreakfastPage(),LunchPage(),SnackPage(),DinnerPage()]),
      ),
    );
  }
}
