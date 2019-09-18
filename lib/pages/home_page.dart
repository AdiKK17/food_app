import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

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
                  return Container(child: Column(
                    children: <Widget>[
                      InkWell(
                        onLongPress: () async {
                          if (await canLaunch(
                              "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}")) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WbviewScreen(
                                    "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}"),
                              ),
                            );
                          }
                        },
                        onDoubleTap: () {
                          Provider.of<Recipe>(context).favoriteIt(
                              context,
                              Provider.of<Recipe>(context).item[index].title,
                              Provider.of<Recipe>(context).item[index].imageUrl,
                              Provider.of<Recipe>(context).item[index].rating,
                              Provider.of<Recipe>(context).item[index].id,
                              Provider.of<Recipe>(context)
                                  .item[index]
                                  .detailSource);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("recipe added to favorites"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
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
                          margin: EdgeInsets.only(left: 3,bottom: 5,right: 3),
                          color: Colors.black38,
                          height: 350,
                          width: double.infinity,
                          child: GridTile(
                            child: Image.network(
                              Provider.of<Recipe>(context).item[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.black38,
                              title: Text(
                                Provider.of<Recipe>(context).item[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 19,fontStyle: FontStyle.italic),
                              ),
                            ),
                            header: GridTileBar(
                              backgroundColor: Colors.black38,
                              title: Text(
                                Provider.of<Recipe>(context).item[index].rating.substring(0,4),
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
//                      Container(
//                        width: double.infinity,
//                        height: 60,
//                        child: Center(
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              IconButton(
//                                icon: Icon(
//                                  Icons.favorite,
//                                  color: Colors.black,
//                                  size: 40,
//                                ),
//                              onPressed: () {
//                                Provider.of<Recipe>(context).favoriteIt(context,
//                                    Provider.of<Recipe>(context)
//                                        .item[index]
//                                        .title,
//                                    Provider.of<Recipe>(context)
//                                        .item[index]
//                                        .imageUrl,
//                                    Provider.of<Recipe>(context)
//                                        .item[index]
//                                        .rating,
//                                    Provider.of<Recipe>(context).item[index].id,
//                                    Provider.of<Recipe>(context)
//                                        .item[index]
//                                        .detailSource);
//                                Scaffold.of(context).hideCurrentSnackBar();
//                                Scaffold.of(context).showSnackBar(
//                                  SnackBar(
//                                    content: Text("recipe added to favorites"),
//                                    duration: Duration(seconds: 2),
//                                  ),
//                                );
//                              },
//                              ),
//                              SizedBox(
//                                width: 80,
//                              ),
//                              IconButton(
//                                icon: Icon(
//                                  Icons.videocam,
//                                  size: 40,
//                                ),
//                              onPressed: () async {
//                                if (await canLaunch(
//                                    "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}")) {
//                                  Navigator.of(context).push(
//                                    MaterialPageRoute(
//                                      builder: (context) => WbviewScreen(
//                                          "https://www.youtube.com/results?search_query=${Provider.of<Recipe>(context).item[index].title}"),
//                                    ),
//                                  );
//                                }
//                              },
//                              )
//                            ],
//                          ),
//                        ),
//                        color: Colors.lightGreen,
//                        margin: EdgeInsets.only(bottom: 10),
//                      )
                    ],
                  ),);
                },
                itemCount: Provider.of<Recipe>(context).item.length,
              ),
      ),
    );
  }
}
