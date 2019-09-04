import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAmJvi2hhrGVIV4mtj87XlVYqfAAjYP6V4";
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {"email": email, "password": password, "returnSecureToken": true},
        ),
      );

      final responseData = json.decode(response.body);

      if(responseData['error'] != null){
          throw HttpException(responseData["error"]["message"]);
      }
    } catch(error) {
      throw error;
    }

  }

  Future<void> login(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAmJvi2hhrGVIV4mtj87XlVYqfAAjYP6V4";
    try {

      final response = await http.post(
        url,
        body: json.encode(
          {"email": email, "password": password, "returnSecureToken": true},
        ),
      );

      final responseData = json.decode(response.body);

      if(responseData['error'] != null){
        throw HttpException(responseData["error"]["message"]);
      }
    } catch(error) {
      throw error;
    }
  
  }


}
