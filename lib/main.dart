import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './pages/auth_page.dart';
import './providers/auth.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: MaterialApp(
        home: AuthenticationPage(),
      ),
    );
  }
}
