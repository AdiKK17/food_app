import 'package:flutter/material.dart';
import 'package:async/async.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/fetch_recipes_by_search.dart';
import '../widgets/webview.dart';

class DataSearch extends SearchDelegate<String> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _memoizer.runOnce(() async {
      await Provider.of<SearchedRecipes>(context).fetchSearchedRecipes(context,query);
    });

    return Provider.of<SearchedRecipes>(context).searchedItems.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                color: Colors.black12,
                child: ListTile(
                  contentPadding: EdgeInsets.all(20),
                  onTap: () async {
                    if (await canLaunch(Provider.of<SearchedRecipes>(context)
                        .searchedItems[index]
                        .detailSource)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WbviewScreen(
                              Provider.of<SearchedRecipes>(context)
                                  .searchedItems[index]
                                  .detailSource),
                        ),
                      );
                    }
                  },
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        Provider.of<SearchedRecipes>(context)
                            .searchedItems[index]
                            .imageUrl),
                  ),
                  title: Text(
                    Provider.of<SearchedRecipes>(context)
                        .searchedItems[index]
                        .title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Rating - ${Provider.of<SearchedRecipes>(context).searchedItems[index].rating}"),
                ),
              );
            },
            itemCount:
                Provider.of<SearchedRecipes>(context).searchedItems.length,
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container(
            child: Center(
              child: Text(
                "Enter a recipe or an ingredient to search",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        : Container(
            child: Center(
              child: Text("Hit Enter for results"),
            ),
          );
  }
}
