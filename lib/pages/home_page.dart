import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../training.dart';
import '../widgets/category_item.dart';
import '../providers/recipe.dart';

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
      Provider.of<Recipe>(context).fetchRecipe().then((_) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {

                    if (await canLaunch(
                        Provider.of<Recipe>(context).item[index].detailSource)) {
                      await launch(
                          Provider.of<Recipe>(context).item[index].detailSource,
                          forceSafariVC: true,
                          forceWebView: true);
                    } else {
                      print("could not launch the url");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 2,right: 2,bottom: 10),
                    height: 300,
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
                );
              },
        itemCount: Provider.of<Recipe>(context).item.length,
            ),
    );
  }
}
