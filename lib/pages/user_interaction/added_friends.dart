import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import 'friends_details/friends_details_page.dart';
import 'friends_details/friends_favorite_page.dart';

class AddedFriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddedFriendsPage();
  }
}

class _AddedFriendsPage extends State<AddedFriendsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Provider.of<Auth>(context).friendsDataList.length == 0 ? Container(child: Center(child: Text("!-_-No Friends-_-!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),) : ListView.builder(
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FriendsProfilePage(
                      Provider.of<Auth>(context).friendsDataList[index].name,
                      Provider.of<Auth>(context)
                          .friendsDataList[index]
                          .username,
                      Provider.of<Auth>(context)
                          .friendsDataList[index]
                          .email))),
              onLongPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FriendsFavoritePage(Provider.of<Auth>(context).friendsDataList[index].name,Provider.of<Auth>(context).friendsDataList[index].firebaseId),),),
              contentPadding: EdgeInsets.all(5),
              leading: CircleAvatar(
                radius: 30,
                child: Text(
                  Provider.of<Auth>(context)
                      .friendsDataList[index]
                      .name[0]
                      .toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                backgroundColor: Colors.cyan,
              ),
              title:
                  Text(Provider.of<Auth>(context).friendsDataList[index].name),
              subtitle:
                  Text(Provider.of<Auth>(context).friendsDataList[index].email),
            ),
            Divider()
          ],
        ),
        itemCount: Provider.of<Auth>(context).friendsDataList.length,
      ),
    );
  }
}
