import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_by_cuisine.dart';
import '../../providers/recipe.dart';

class LunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LunchPage();
  }
}

class _LunchPage extends State<LunchPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<RecipeByCuisine>(context).fetchRecipes("Brunch").then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () async {
                if (await canLaunch(Provider.of<RecipeByCuisine>(context)
                    .cuisineList[index]
                    .detailSource)) {
                  await launch(
                    Provider.of<RecipeByCuisine>(context)
                        .cuisineList[index]
                        .detailSource,
                    forceSafariVC: true,
                    forceWebView: true,
                  );
                } else {
                  print("could not launch the url");
                }
              },
              child: Container(
                color: Colors.black38,
                height: 350,
                width: double.infinity,
                child: GridTile(
                  child: Image.network(
                    Provider.of<RecipeByCuisine>(context).cuisineList[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black38,
                    title: Text(
                      Provider.of<RecipeByCuisine>(context).cuisineList[index].title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  header: GridTileBar(
                    backgroundColor: Colors.black38,
                    title: Text(
                      Provider.of<RecipeByCuisine>(context).cuisineList[index].rating,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    Provider.of<Recipe>(context).favoriteIt(
                        Provider.of<RecipeByCuisine>(context).cuisineList[index].title,
                        Provider.of<RecipeByCuisine>(context)
                            .cuisineList[index]
                            .imageUrl,
                        Provider.of<RecipeByCuisine>(context).cuisineList[index].rating,
                        Provider.of<RecipeByCuisine>(context).cuisineList[index].id,
                        Provider.of<RecipeByCuisine>(context)
                            .cuisineList[index]
                            .detailSource);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Recipe added to favorites"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              color: Colors.lightGreen,
              margin: EdgeInsets.only(bottom: 10),
            )
          ],
        );
      },
      itemCount: Provider.of<RecipeByCuisine>(context).cuisineList.length,
//      ),
    );
  }
}
