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
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Recipe>(context).fetchRecipes().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshHomeProducts(BuildContext context) async {
    await Provider.of<Recipe>(context).fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
        backgroundColor: Colors.lightGreen,
        title: Text(
          "ReciPedia",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      drawer: TheDrawer(),
      body: RefreshIndicator(onRefresh: () => _refreshHomeProducts(context),child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
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
                            ),
                          ),
                          header: GridTileBar(
                            backgroundColor: Colors.black38,
                            title: Text(
                              Provider.of<Recipe>(context).item[index].rating,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                Provider.of<Recipe>(context).favoriteIt(
                                    Provider.of<Recipe>(context)
                                        .item[index]
                                        .title,
                                    Provider.of<Recipe>(context)
                                        .item[index]
                                        .imageUrl,
                                    Provider.of<Recipe>(context)
                                        .item[index]
                                        .rating,
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
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.videocam,
                                size: 40,
                              ),
                              onPressed: () async {
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
                            )
                          ],
                        ),
                      ),
                      color: Colors.lightGreen,
                      margin: EdgeInsets.only(bottom: 10),
                    )
                  ],
                );
              },
              itemCount: Provider.of<Recipe>(context).item.length,
            ),
    ),);
  }
}
