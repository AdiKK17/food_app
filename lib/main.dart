import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './pages/auth_page.dart';
import './providers/auth.dart';
import './pages/loading_page.dart';
import './providers/recipe.dart';
import './providers/shopping_list.dart';
import './providers/recipe_by_cuisine.dart';
import './providers/fetch_recipes_by_search.dart';

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
        ChangeNotifierProvider.value(value: Recipe()),
        ChangeNotifierProvider.value(value: ShoppingIngredients()),
        ChangeNotifierProvider.value(value: RecipeByCuisine()),
        ChangeNotifierProvider.value(value: SearchedRecipes()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuthenticated
              ? HomePage()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthenticationPage()),
        ),
      ),
    );
  }
}
