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

  List<String> _userNotifications = [];
//  List<String> _userIdList = []; //containes UID from firebase of all users
  List<UserDetails> _usersDataDetails = [];
  List<UserDetails> _friendsDataList = [];
  List<String> _userFriendsIds = []; //containes UID of a User's friends

  Map<String, dynamic> _userData = {
    "name": null,
    "username": null,
    "email": null,
  };

  //getters

  List<String> get userNotifications{
    return List.from(_userNotifications);
  }

  List<String> get userFriendsIds{
    return List.from(_userFriendsIds);
  }

  List<UserDetails> get friendsDataList{
    return List.from(_friendsDataList);
  }

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

  //END OF GETTERS//



  //userInteraction segment

  Future<void> setUpUserData(
      String name, String username, String email, String firebaseId) async {
    final url =
        "https://recipedia-58d9b.firebaseio.com/userData/$firebaseId.json";
    await http.put(
      url,
      body: json.encode(
        {
          "firebaseId": firebaseId,
          "name": name,
          "userName": username,
          "email": email
        },
      ),
    );
  }

  Future<void> fetchUserDetails() async {
    final url = "https://recipedia-58d9b.firebaseio.com/userData/$_userId.json";

    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;


    _userData["name"] = responseData["name"];
    _userData["username"] = responseData["userName"];
    _userData["email"] = responseData["email"];
    notifyListeners();
  }

  Future<void> updateUserDetails(String name,String username) async {
    final url = "https://recipedia-58d9b.firebaseio.com/userData/$_userId.json";
      await http.get(url);
    await http.patch(url,body: json.encode({"name" : name, "userName" : username},),);
    await fetchUserDetails();
    notifyListeners();
  }


  Future<void> fetchAllUsersData() async {
    final url = "https://recipedia-58d9b.firebaseio.com/userData.json";
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String,dynamic>;
    if(responseData == null){
      return;
    }
    final List<UserDetails> usersDatasDetails = [];

    responseData.forEach((key,value){
      if(key != _userId){
        usersDatasDetails.add(UserDetails(name: value["name"], username: value["userName"], email: value["email"], firebaseId: value["firebaseId"],),);
      }
    });

    _usersDataDetails = usersDatasDetails;
    notifyListeners();
  }

  //SEGMENT ENDED//

  //adding friends


  Future<void> fetchUserFriendsIds() async {
    final url = "https://recipedia-58d9b.firebaseio.com/$_userId/friends.json";
    final List<String> temporaryUserFriendsIds = [];
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String,dynamic>;
    if(responseData == null){
      return;
    }
    responseData.forEach((key,value){
      temporaryUserFriendsIds.add(value["firebaseId"]);
    });
    _userFriendsIds = temporaryUserFriendsIds;
    notifyListeners();
  }

  Future<void> addFriends(String name, String username,
      String email, String firebaseId) async {
    sendFollowingNotification(firebaseId);
    final url =
        "https://recipedia-58d9b.firebaseio.com/$_userId/friends.json";
    if(!_userFriendsIds.contains(firebaseId)){
      await http.post(
        url,
        body: json.encode(
          {
            "name": name,
            "userName": username,
            "email": email,
            "firebaseId": firebaseId
          },
        ),
      );
      getFriends();
      await fetchUserFriendsIds();
    }
  }

  Future<void> getFriends() async {
    final url =  "https://recipedia-58d9b.firebaseio.com/$_userId/friends.json";
    final List<UserDetails> temporaryFriendsList = [];
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String,dynamic>;
    if(responseData == null){
      return;
    }
    responseData.forEach((key,value) {
      temporaryFriendsList.add(UserDetails(name: value["name"], username: value["userName"], email: value["email"], firebaseId: value["firebaseId"],),);
    });
    _friendsDataList = temporaryFriendsList;
    notifyListeners();
  }

  //ADDING FRIENDS ENDED//

  //sending notifications

  Future<void> sendFollowingNotification(String addedFriendFirebaseId) async {
    final url =
        "https://recipedia-58d9b.firebaseio.com/$addedFriendFirebaseId/notifications.json";
    await http.post(url,body: json.encode({"name" : _userData["name"],},),);
  }


  Future<void> fetchNotifications() async {
    final url = "https://recipedia-58d9b.firebaseio.com/$_userId/notifications.json";
    final List<String> temporaryNotificationList = [];
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String,dynamic>;
    if(responseData == null){
      return;
    }
    responseData.forEach((key,value) {
      temporaryNotificationList.add(value["name"]);
    },);
    _userNotifications = temporaryNotificationList;
    notifyListeners();
  }

  //SENDING NOTIFICATION ENDED//

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
      fetchNotifications();

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
      getFriends();
      fetchUserFriendsIds();
      fetchNotifications();

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
    getFriends();
    fetchUserFriendsIds();
    fetchNotifications();
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
