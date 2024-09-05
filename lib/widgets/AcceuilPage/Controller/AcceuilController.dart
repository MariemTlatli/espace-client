import 'package:dio/dio.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/widgets/AcceuilPage/Provider/AcceuilProvider.dart';

import 'package:espace_client/widgets/AcceuilPage/Service/AcceuilService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/widgets/LoginPage/Provider/UserProvider.dart';

class AcceuilController {
  BuildContext context;
  // instance service
  final acceuilService = AcceuilService(api: DioConsumer(dio: Dio()));
  // instance provider
  var userProvider;
  var acceuilProvider;
  // login controlleur
  AcceuilController({
    required this.context,
  }) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    acceuilProvider = Provider.of<AcceuilProvider>(context, listen: false);
  }

  GetListPriorites(context) async {
    final response = await acceuilService.getListPriorites();

    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (liste) async {
        acceuilProvider.setListPriorites(liste);
        acceuilProvider.printPriorities(acceuilProvider.listePriorites);
      },
    );
  }

  GetMaListTaches2(context) async {
    final response = await acceuilService
        .getListTaches(MySharedPrefrences.sharedPreferences.getString(
      ApiKey.id,
    ));
    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (liste) async {
        acceuilProvider.setListPriorites(liste);
        acceuilProvider.printPriorities(acceuilProvider.listePriorites);
      },
    );
  }

  void GetMaListTaches(BuildContext context) async {
    //GetListPriorites(context);
    final response = await acceuilService
        .getListTaches(MySharedPrefrences.sharedPreferences.getString(
      ApiKey.id,
    ));
    //final response = await acceuilService.getListPriorites();
  }
}
