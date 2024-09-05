import 'package:dio/dio.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/widgets/MyContainer/Views/MyContainerView.dart';
import 'package:espace_client/widgets/CorbeilleTest/FadeTransitionLogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';
import '../Service/LoginService.dart';

class LoginController {
  BuildContext context;
  // instance service
  final loginService = LoginService(api: DioConsumer(dio: Dio()));
  // instance provider
  var myProvider;

  // login controlleur
  LoginController({
    required this.context,
  }) {
    myProvider = Provider.of<UserProvider>(context, listen: false);
  }

  // premiere requete
  GetAcessToken(context) async {
    final response = await loginService.GetAcessToken();

    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (token) async {
        myProvider.setToken(token);
        print("user token is : $token");
      },
    );
  }

  // 2eme requete
  VerifierMail(email, context) async {
    myProvider.setIsLoading(true);
    final response =
        await loginService.testMail(mail: email, token: myProvider.user.token);
    myProvider.setIsLoading(false);
    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
        if (errMessage == "Pas du client avec cette adresse mail") {
          myProvider.setVisibleMail(false);
          myProvider.setVisiblePass(true);
          myProvider.setVisibleConfirmPass(true);
        } else {
          myProvider.setVisibleMail(true);
          myProvider.setVisiblePass(false);
          myProvider.setVisibleConfirmPass(false);
        }
      },
      (response) async {
        CustomFlushbar.showFlushbar(context, response["message"],
            backgroundColor: constants.ButtonColor);
        myProvider.setUserState(response[ApiKey.key]);
        if (response[ApiKey.key] == "login") {
          myProvider.setVisibleMail(false);
          myProvider.setVisiblePass(true);
          myProvider.setVisibleConfirmPass(false);
        }

        if (response[ApiKey.key] == "add") {
          myProvider.setVisibleMail(false);
          myProvider.setVisiblePass(true);
          myProvider.setVisibleConfirmPass(true);
        }
        MySharedPrefrences().logSharedPreferences();
      },
    );
  }

  // 3eme requete
  HandleLoginUserExist(email, password, key) async {
    final response = await loginService.HandleLoginUser(
        email: email, password: password, key: key);
    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (mapResult) async {
        CustomFlushbar.showFlushbar(context, mapResult[ApiKey.message],
            backgroundColor: constants.greenColor);
        myProvider.setUserId(mapResult[ApiKey.id]);
        myProvider.setUserName(mapResult[ApiKey.userName]);
        final navigator = Navigator.of(context);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => FadeTransitionLogo(),
          ),
          (route) => false,
        );
        print("*****************");
        print(mapResult);
        print("*****************");
      },
    );
  }
}
