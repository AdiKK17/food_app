import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../http_exception.dart';
import '../models/user_data.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  String _userEmail;

  List<String> _userIdList = []; //containes UID from firebase of all users
  List<UserDetails> _usersDataDetails = [];

  Map<String, dynamic> _userData = {
    "name": null,
    "username": null,
    "email": null,
  };

  //getters

  List<UserDetails> get usersDataDetails {
    return List.from(_usersDataDetails);
  }

  Map<String, dynamic> get userData {
    return _userData;
  }

  bool get isAuthenticated {
    return token != null;
  }

  String get userEmail {
    return _userEmail;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //end of getters//



  //userInteraction segment

  Future<void> setUpUserData(
      String name, String username, String email, String firebaseId) async {
    final url =
        "https://recipedia-58d9b.firebaseio.com/userData/$firebaseId.json";
    await http.post(
      url,
      body: json.encode(
        {"name": name, "userName": username, "email": email},
      ),
    );
  }

  Future<void> fetchUserDetails() async {
    final url = "https://recipedia-58d9b.firebaseio.com/userData/$_userId.json";

    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    responseData.forEach((fireId, userData) {
      _userData["name"] = userData["name"];
      _userData["username"] = userData["userName"];
      _userData["email"] = userData["email"];
    });
    notifyListeners();
  }

  Future<void> fetchAllUserDataIds() async {
    final url = "https://recipedia-58d9b.firebaseio.com/userData.json";
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    responseData.forEach(
      (key, value) {
        _userIdList.add(key);
      },
    );
    notifyListeners();
  }

  Future<void> fetchAllUsersData() async {
    await fetchAllUserDataIds();
    final List<UserDetails> usersDatasDetails = [];
    _userIdList.forEach((id) async {
      final url = "https://recipedia-58d9b.firebaseio.com/userData/$id.json";
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      responseData.forEach((key, value) {
        usersDatasDetails.add(UserDetails(
            name: value["name"],
            username: value["userName"],
            email: value["email"]));

        print(key);
        print(value["name"]);
        print(value["userName"]);
        print(value["email"]);

      });
    });
    _usersDataDetails = usersDatasDetails;
    notifyListeners();
  }

  //SEGMENT ENDED//


  Future<void> signUp(
      String name, String username, String email, String password) async {
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

      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }

      //      print(responseData["idToken"]);
      //      print(responseData["localId"]);                                                   //local id is the id given by the firebase to a user

      _userEmail = responseData["email"];
      setUpUserData(name, username, email, responseData["localId"]);

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expiresIn"],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();

      fetchUserDetails();
      fetchAllUsersData();

      final prefs = await SharedPreferences.getInstance();
      final userAuthData = json.encode(
        {
          "email": _userEmail,
          "token": _token,
          "userId": _userId,
          "expiryDate": _expiryDate.toIso8601String(),
        },
      );
      prefs.setString("userAuthData", userAuthData);
    } catch (error) {
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

      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }

      _userEmail = responseData["email"];

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expiresIn"],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();

      fetchUserDetails();
      fetchAllUsersData();

      final prefs = await SharedPreferences.getInstance();
      final userAuthData = json.encode(
        {
          "email": _userEmail,
          "token": _token,
          "userId": _userId,
          "expiryDate": _expiryDate.toIso8601String(),
        },
      );
      prefs.setString("userAuthData", userAuthData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userAuthData")) {
      return false;
    }

    final extractedUserAuthData =
        json.decode(prefs.getString("userAuthData")) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserAuthData["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _userEmail = extractedUserAuthData["email"];
    _token = extractedUserAuthData["token"];
    _userId = extractedUserAuthData["userId"];
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();
    fetchUserDetails();
    fetchAllUsersData();
    return true;
  }

  Future<void> logout() async {
    _expiryDate = null;
    _userId = null;
    _token = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final expiryTime = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiryTime), logout);
  }
}
