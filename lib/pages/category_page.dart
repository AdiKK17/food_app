import 'package:flutter/material.dart';

import './categories/breakfast_page.dart';

class ShowCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          backgroundColor: Colors.green,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("BreakFast"),
              ),
              Tab(
                child: Text("Brunch"),
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
        body: TabBarView(children: [BreakFastPage("breakfast"),BreakFastPage("brunch"),BreakFastPage("snacks"),BreakFastPage("dinner")]),
      ),
    );
  }
}
