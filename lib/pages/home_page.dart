import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../widgets/drawer.dart';
import '../widgets/search_action.dart';
import '../providers/recipe.dart';
import '../widgets/webview.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    try {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        Provider.of<Recipe>(context).fetchRecipes(context).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
      _isInit = false;
    } catch (error) {
      var errorMessage = "Could not fetch Data! Try again later";
      print(errorMessage);
      _showErrorDialog(errorMessage);
    }
    super.didChangeDependencies();
  }

  Future<void> _refreshHomeProducts(BuildContext context) async {
    await Provider.of<Recipe>(context).fetchRecipes(context);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("An error Occured!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
        backgroundColor: Color.fromRGBO(144, 238, 144, 1),
        title: Image.asset(
          "assets/Logo-nav.png",
          height: 50,
          width: 500,
        ),
        centerTitle: true,
      ),
      drawer: TheDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshHomeProducts(context),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            if (await canLaunch(Provider.of<Recipe>(context)
                                .item[index]
                                .detailSource)) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WbviewScreen(
                                      Provider.of<Recipe>(context)
                                          .item[index]
                                          .detailSource),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 3, bottom: 5, right: 3),
                            height: 180,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 180,
                                  height: 120,
                                  child: Card(
//                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        Provider.of<Recipe>(context)
                                            .item[index]
                                            .imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          Provider.of<Recipe>(context)
                                                      .item[index]
                                                      .title
                                                      .length >=
                                                  30
                                              ? "${Provider.of<Recipe>(context).item[index].title.substring(0, 30)}..."
                                              : Provider.of<Recipe>(context)
                                                  .item[index]
                                                  .title,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        SmoothStarRating(
                                            allowHalfRating: true,
                                            starCount: 5,
                                            rating: double.parse(
                                                Provider.of<Recipe>(context).item[index].rating)*(5/100),
                                            size: 30.0,
                                            color: Colors.greenAccent,
                                            borderColor: Colors.black87,
                                            spacing: 0.0),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(fontSize: 17),
                                                children: [
                                                  TextSpan(
                                                    text: (double.parse(Provider.of<Recipe>(context).item[index].rating)*(5/100)).toString().substring(0,4),
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  TextSpan(
                                                      text: "/5",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87))
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Provider.of<Recipe>(context)
                                                        .item[index]
                                                        .isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.lightGreen,
                                              ),
                                              onPressed: () {
                                                Provider.of<Recipe>(context)
                                                    .toggleFavoriteStatus(
                                                        index);
                                                if (Provider.of<Recipe>(context)
                                                    .item[index]
                                                    .isFavorite) {
                                                  Provider.of<Recipe>(
                                                          context)
                                                      .favoriteIt(
                                                          context,
                                                          Provider.of<Recipe>(
                                                                  context)
                                                              .item[index]
                                                              .title,
                                                          Provider.of<Recipe>(
                                                                  context)
                                                              .item[index]
                                                              .imageUrl,
                                                          Provider.of<Recipe>(
                                                                  context)
                                                              .item[index]
                                                              .rating,
                                                          Provider.of<Recipe>(
                                                                  context)
                                                              .item[index]
                                                              .id,
                                                          Provider.of<Recipe>(
                                                                  context)
                                                              .item[index]
                                                              .detailSource);
                                                  Scaffold.of(context)
                                                      .hideCurrentSnackBar();
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "recipe added to favorites"),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.play_circle_outline,
                                                color: Colors.lightGreen,
                                              ),
                                              onPressed: () async {
                                                if (await canLaunch(
                                                    "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}")) {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          WbviewScreen(
                                                              "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}"),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          indent: 15,
                          endIndent: 15,
                        )
                      ],
                    ),
                  );
                },
                itemCount: Provider.of<Recipe>(context).item.length,
              ),
      ),
    );
  }
}
