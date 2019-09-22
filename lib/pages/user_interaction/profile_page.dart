import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './edit_user_details.dart';
import '../../providers/auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditUserDetailsPage(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
//              color: Color.fromRGBO(r, g, b, opacity),
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
                          Provider.of<Auth>(context).userData["name"] == null ? "Loading.." : Provider.of<Auth>(context).userData["name"],
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
                          Provider.of<Auth>(context).userData["username"] == null ? "Loading.." : Provider.of<Auth>(context).userData["username"],
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
                          "E-mail:",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Provider.of<Auth>(context).userData["email"] == null ? "Loading.." : Provider.of<Auth>(context).userData["email"],
                          style: TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
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
