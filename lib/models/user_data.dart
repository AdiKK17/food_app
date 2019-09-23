import 'package:flutter/material.dart';

class UserDetails{
  final String name;
  final String username;
  final String email;
  final String firebaseId;
  final bool isFriend;

  UserDetails({@required this.name,@required this.username,@required this.email,@required this.firebaseId,this.isFriend = false});

}