import 'package:flutter/material.dart';

class FriendsProfilePage extends StatelessWidget {
  final String name;
  final String username;
  final String email;

  FriendsProfilePage(this.name, this.username, this.email);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("${name.toUpperCase()}'s Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Color.fromRGBO(187, 239, 176, 0.4),
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 130,
                      width: 130,
                      child: Image.asset(
                        "assets/student.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Name:",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 25, fontFamily: "Nexa"),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.black),
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Username:",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          username,
                          style: TextStyle(
                              fontSize: 25, fontFamily: "Nexa"),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 100,
                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "E-mail:",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                            email,
                            style: TextStyle(
                                fontSize: 24, fontFamily: "Nexa"),
                          ),
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
