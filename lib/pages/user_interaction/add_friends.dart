import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth.dart';

class AddFriendsPage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddFriendsPage();
  }
}

class _AddFriendsPage extends State<AddFriendsPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(5),
              leading: CircleAvatar(
                radius: 30,
                child: Text(
                  Provider.of<Auth>(context)
                      .usersDataDetails[index]
                      .name[0]
                      .toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                backgroundColor: Colors.cyan,
              ),
              title: Text(
                  Provider.of<Auth>(context).usersDataDetails[index].name),
              subtitle: Text(
                  Provider.of<Auth>(context).usersDataDetails[index].email),
              trailing: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Follow",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Provider.of<Auth>(context).addFriends(
                        Provider.of<Auth>(context).usersDataDetails[index].name,
                        Provider.of<Auth>(context)
                            .usersDataDetails[index]
                            .username,
                        Provider.of<Auth>(context)
                            .usersDataDetails[index]
                            .email,
                        Provider.of<Auth>(context)
                            .usersDataDetails[index]
                            .firebaseId);
                  }),
            ),
            Divider()
          ],
        ),
        itemCount: Provider.of<Auth>(context).usersDataDetails.length,
      ),
    );
  }
}