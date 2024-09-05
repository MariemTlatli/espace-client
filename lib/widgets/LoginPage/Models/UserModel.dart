import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  String email;
  String password;
  String confirmPassword;
  String token;
  String id;
  String userName;
  User(
      {required this.email,
      required this.password,
      required this.confirmPassword,
      required this.token,
      required this.id,
      required this.userName});
}
