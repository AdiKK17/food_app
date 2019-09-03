import 'package:flutter/material.dart';

import 'home_page.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthenticationPage();
  }
}

class _AuthenticationPage extends State<AuthenticationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  final Map<String, dynamic> _formData = {
    "email": null,
    "password": null,
  };

  DecorationImage _buildBackGroundImage() {
    return DecorationImage(
        fit: BoxFit.cover, image: AssetImage("assets/authImage.jpg"));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text(
        "LOGIN",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

//    final double deviceWidth = MediaQuery.of(context).size.width * 90 ;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: _buildBackGroundImage(),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 220),
                alignment: Alignment.center,
                child: Text(
                  "ReciPedia",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 50),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                child: _buildEmailTextField(),
                width: 350,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: _buildPasswordTextField(),
                width: 350,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: _buildSubmitButton(),
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
