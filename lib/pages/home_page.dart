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
        backgroundColor: Colors.white10,
        title: Text("ReciPedia",style: TextStyle(color: Colors.black87,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
        centerTitle: true,
      ),
      drawer: TheDrawer(),
    );
  }
}
