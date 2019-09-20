import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationsPage();
  }
}

class _NotificationsPage extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("Notifications"),centerTitle: true,),body: RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            ListTile(
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context) => FriendsProfilePage(
//                      Provider.of<Auth>(context).friendsDataList[index].name,
//                      Provider.of<Auth>(context)
//                          .friendsDataList[index]
//                          .username,
//                      Provider.of<Auth>(context)
//                          .friendsDataList[index]
//                          .email))),
//              onLongPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FriendsFavoritePage(Provider.of<Auth>(context).friendsDataList[index].name,Provider.of<Auth>(context).friendsDataList[index].firebaseId),),),
              contentPadding: EdgeInsets.all(5),
              leading: CircleAvatar(
                radius: 30,
                child: Icon(Icons.accessibility),
                backgroundColor: Colors.cyan,
                ),
              title:
              Text("${Provider.of<Auth>(context).userNotifications[index]} started following you!",style: TextStyle(fontSize: 18),),
            ),
            Divider()
          ],
        ),
        itemCount: Provider.of<Auth>(context).userNotifications.length,
      ),
    ),);
  }
}
