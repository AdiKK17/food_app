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
        backgroundColor: Colors.green,
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
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
            color: Color.fromRGBO(187, 239, 176, 0.8),
              child: Center(
                child: Container(
                  child: Center(
                    child: Container(
                      height: 140,
                      width: 140,
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
                        Text(
                          "Name:  ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Provider.of<Auth>(context).userData["name"] == null
                              ? "Loading.."
                              : Provider.of<Auth>(context).userData["name"],
                          style: TextStyle(
                              fontSize: 30, fontFamily: "Nexa",fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(indent: 20,endIndent: 20,color: Colors.cyan,),
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Username:  ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Provider.of<Auth>(context).userData["username"] ==
                                  null
                              ? "Loading.."
                              : Provider.of<Auth>(context).userData["username"],
                          style: TextStyle(
                              fontSize: 30, fontFamily: "Nexa",fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(indent: 20,endIndent: 20,color: Colors.cyan,),
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "E-mail:  ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            Provider.of<Auth>(context).userData["email"] == null
                                ? "Loading.."
                                : Provider.of<Auth>(context).userData["email"],
                            style: TextStyle(
                                fontSize: 30, fontFamily: "Nexa" ,fontWeight: FontWeight.bold),
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
