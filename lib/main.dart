import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/auth_page.dart';

main() {
  runApp(MyFoodApp());
}

class MyFoodApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFoodApp();
  }
}

class _MyFoodApp extends State<MyFoodApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: AuthenticationPage(),
    );
  }
}
