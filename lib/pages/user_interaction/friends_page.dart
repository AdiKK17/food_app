import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import './add_friends.dart';
import './added_friends.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FriendsPage();
  }
}

class _FriendsPage extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Friends"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Friends"),
              ),
              Tab(child: Text("Add Friends"),)
            ],
          ),
        ),
        body: TabBarView(children: [AddedFriendsPage(),AddFriendsPage()],),
      ),
    );
  }
}
