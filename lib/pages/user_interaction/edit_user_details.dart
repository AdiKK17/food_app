import 'package:flutter/material.dart';

class EditUserDetailsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditUserDetailsPage();
  }

}

class _EditUserDetailsPage extends State<EditUserDetailsPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _username;

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        suffixIcon: Icon(
          Icons.edit,
        ),
      ),
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
//      initialValue: "hoax",
      decoration: InputDecoration(
        labelText: "UserName",
        suffixIcon: Icon(
          Icons.edit,
        ),
      ),
//      validator: (String value) {
//        if (value.isEmpty) {
//          return "Please enter the name";
//        }
//      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }


  void _submitForm() {
//    if (!_formKey.currentState.validate() && _formData["account"] == null) {
//      return;
//    }
    _formKey.currentState.save();


    Navigator.pop(context);

//    Fluttertoast.showToast(
//        msg: "Expense Added",
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.grey,
//        textColor: Colors.black,
//        fontSize: 16.0
//    );

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: Container(
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
                  SizedBox(height: 50,),
                  Container(width: 100,child:
                  RaisedButton(child: Text("Submit"),onPressed: () => _submitForm,),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
