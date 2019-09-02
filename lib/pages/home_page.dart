import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Food App"),
        centerTitle: true,
      ),
      drawer: TheDrawer(),
    );
  }
}
