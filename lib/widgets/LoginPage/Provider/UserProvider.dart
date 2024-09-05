import 'package:dio/dio.dart';
import 'package:espace_client/widgets/LoginPage/Models/UserModel.dart';
import 'package:espace_client/widgets/LoginPage/Service/LoginService.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // instance service
  final loginService = LoginService(api: DioConsumer(dio: Dio()));
  // variables loginFormView
  bool isTextFieldMailVisible = true;
  bool isTextFieldPasswordVisible = false;
  bool isTextFieldConfirmPasswordVisible = false;
  bool obscureTextPass = true;
  bool obscureTextConfirmPass = true;

  bool isButtonEnabled = true;
  bool _isLoading = false;
  String userState = "";

  // instance du model user pour stocker ses coordonnées
  User _user = User(
      email: '',
      password: '',
      confirmPassword: '',
      token: '',
      id: '',
      userName: '');

// getter & setter
  User get user => _user;
  bool get isLoading => _isLoading;
  void setUserName(v) {
    _user.userName = v;
    notifyListeners();
  }

  void setUserState(v) {
    userState = v;
    notifyListeners();
  }

  void setIsButtonEnabled(v) {
    isButtonEnabled = v;
    print(isButtonEnabled);
    notifyListeners();
  }

  void setIsLoading(v) {
    _isLoading = v;
    notifyListeners();
  }

  void setobscureTextPass(v) {
    obscureTextPass = v;
    notifyListeners();
  }

  void setobscureTextConfirmPass(v) {
    obscureTextConfirmPass = v;
    notifyListeners();
  }

  void setUserId(v) {
    _user.id = v;
    notifyListeners();
  }

  void setMail(v) {
    _user.email = v;
    print(_user.email);
    notifyListeners();
  }

  void setPassword(v) {
    _user.password = v;
    notifyListeners();
  }

  void setConfirmPassword(v) {
    _user.confirmPassword = v;
    notifyListeners();
  }

  void setVisibleMail(v) {
    isTextFieldMailVisible = v;
    notifyListeners();
  }

  void setToken(v) {
    _user.token = v;
    notifyListeners();
  }

  void setVisiblePass(v) {
    isTextFieldPasswordVisible = v;
    notifyListeners();
  }

  void setVisibleConfirmPass(v) {
    isTextFieldConfirmPasswordVisible = v;
    notifyListeners();
  }

  String get Getpassword {
    return _user.password;
  }

  String get GetConfirmPassword {
    return _user.confirmPassword;
  }

  String get Getemail {
    return _user.email;
  }

  void resetUserData() {
    _user = User(
      email: '',
      password: '',
      confirmPassword: '',
      token: '',
      id: '',
      userName: '',
    );
    isTextFieldMailVisible = true;
    isTextFieldPasswordVisible = false;
    isTextFieldConfirmPasswordVisible = false;
    obscureTextPass = true;
    obscureTextConfirmPass = true;
    isButtonEnabled = true;
    _isLoading = false;
    userState = '';

    notifyListeners();
  }
}
