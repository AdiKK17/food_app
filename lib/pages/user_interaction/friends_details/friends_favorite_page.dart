import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/recipe.dart';
import '../../../widgets/webview.dart';

class FriendsFavoritePage extends StatefulWidget {

  final String fireId;
  final String name;

  FriendsFavoritePage(this.name,this.fireId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FriendsFavoritePage();
  }
}

class _FriendsFavoritePage extends State<FriendsFavoritePage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Recipe>(context).createParticularUserFavoriteList(context, widget.fireId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Recipe>(context).createParticularUserFavoriteList(context, widget.fireId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "${widget.name.toUpperCase()}'s Favorites",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Provider.of<Recipe>(context).particularUserFavoriteRecipes.length == 0
            ? Center(
          child: Text(
            "No favorites found!",
            style: TextStyle(fontSize: 30),
          ),
        )
            : ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10),
              color: Colors.black12,
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                onTap: () async {
                  if (await canLaunch(Provider.of<Recipe>(context)
                      .particularUserFavoriteRecipes[index]
                      .detailSource)) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WbviewScreen(
                            Provider.of<Recipe>(context)
                                .particularUserFavoriteRecipes[index]
                                .detailSource),
                      ),
                    );
                  }
                },
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      Provider.of<Recipe>(context)
                          .particularUserFavoriteRecipes[index]
                          .imageUrl),
                ),
                title: Text(
                  Provider.of<Recipe>(context)
                      .particularUserFavoriteRecipes[index]
                      .title,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "Rating - ${Provider.of<Recipe>(context).particularUserFavoriteRecipes[index].rating}"),
//                trailing: IconButton(
//                    icon: Icon(Icons.delete),
//                    onPressed: () => Provider.of<Recipe>(context)
//                        .deFavoriteIt(context,index)),
              ),
            );
          },
          itemCount:
          Provider.of<Recipe>(context).particularUserFavoriteRecipes.length,
        ),
      ),
    );
  }
}
