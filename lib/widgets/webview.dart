import 'package:flutter/material.dart';

//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WbviewScreen extends StatefulWidget {
  final String urlText;

  WbviewScreen(this.urlText);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WbviewScreen();
  }
}

class _WbviewScreen extends State<WbviewScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.urlText,style: TextStyle(fontSize: 15,color: Colors.white),),
        backgroundColor: Colors.black54,
      ),
      url: widget.urlText,
    );
  }
}
