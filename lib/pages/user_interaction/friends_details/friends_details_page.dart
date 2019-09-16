import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

import '../edit_user_details.dart';
//import '../../../providers/auth.dart';

class FriendsProfilePage extends StatelessWidget {
  final String name;
  final String username;
  final String email;

  FriendsProfilePage(this.name, this.username, this.email);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${name.toUpperCase()}'s Profile"),
      ),
      body: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.blueGrey,
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 110,
                      width: 110,
                      color: Colors.red,
                      child: Image.asset(
                        "assets/default.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              height: 400,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "UserName",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          username,
                          style: TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child:
                  Container(
                      child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "E-mail:",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                  )




                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
