import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/auth.dart';

class EditUserDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditUserDetailsPage();
  }
}

class _EditUserDetailsPage extends State<EditUserDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  String _name;
  String _username;

  Widget _buildNameTextField() {
    return TextFormField(
      initialValue: Provider.of<Auth>(context).userData["name"],
      decoration: InputDecoration(
        labelText: "Name",
        suffixIcon: Icon(
          Icons.edit,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "This field can't be empty";
        } else
          return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
      initialValue: Provider.of<Auth>(context).userData["username"],
      decoration: InputDecoration(
        labelText: "UserName",
        suffixIcon: Icon(
          Icons.edit,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "This field can't be empty";
        } else
          return null;
      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    await Provider.of<Auth>(context).updateUserDetails(_name, _username);

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);

    Fluttertoast.showToast(
        msg: "Profile Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Edit Details"),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: Text(
                  "Updating...",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Container(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _buildNameTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildUserNameTextField(),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 100,
                          child: RaisedButton(
                              color: Colors.green,
                              child: Text("Submit"),
                              onPressed: () => _submitForm()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
