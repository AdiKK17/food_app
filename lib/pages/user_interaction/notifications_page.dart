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
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(15),
                leading: CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.accessibility),
                  backgroundColor: Colors.cyan,
                ),
                title: Text(
                  "${Provider.of<Auth>(context).userNotifications[index]} started following you!",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
            ],
          ),
          itemCount: Provider.of<Auth>(context).userNotifications.length,
        ),
      ),
    );
  }
}
