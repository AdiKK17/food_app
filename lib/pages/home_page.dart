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
        backgroundColor: Color.fromRGBO(237, 42, 95, 1),
        title: Text(
          "ReciPedia",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
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
                    color: Color.fromRGBO(237, 42, 95, 1),
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
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.grey],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            height: 240,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 190,
                                  height: 140,
                                  child: Card(
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    elevation: 15,
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
//                                    color: Colors.blue,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: Provider.of<Recipe>(context).item[index].title.length >= 70 ? 10 : 50,
                                        ),
                                        Text(
                                          Provider.of<Recipe>(context)
                                              .item[index]
                                              .title,
                                          style: TextStyle(
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
                                                        Provider.of<Recipe>(
                                                                context)
                                                            .item[index]
                                                            .rating) >=
                                                    80
                                                ? 5
                                                : 3.5,
                                            size: 30.0,
                                            color: Colors.deepOrangeAccent,
                                            borderColor: Colors.black,
                                            spacing: 0.0),
                                        SizedBox(
                                          height: 3,
                                        ),
//                                        Text(
//                                          "3/5",
//                                          style: TextStyle(fontSize: 18),
//                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              "3/5",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.favorite_border),
                                              onPressed: () {
                                                Provider.of<Recipe>(context)
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
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.play_circle_outline),
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
                          color: Colors.grey,
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
