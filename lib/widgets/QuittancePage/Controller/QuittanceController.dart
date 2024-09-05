import 'package:dio/dio.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/widgets/QuittancePage/Provider/QuittanceProvider.dart';
import 'package:espace_client/widgets/QuittancePage/Service/QuittanceService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class QuittanceController {
  BuildContext context;
  // instance service
  final quittanceService = QuittanceService(api: DioConsumer(dio: Dio()));
  // instance provider
  var myProvider;

  // login controlleur
  QuittanceController({
    required this.context,
  }) {
    myProvider = Provider.of<QuittanceProvider>(context, listen: false);
  }

  Future<void> GetAllQuittances(BuildContext context, String? id) async {
    final response = await quittanceService.GetAllQuittances(id);

    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (mesContrats) async {
        myProvider.setListContrats(mesContrats);
        myProvider.setListContratsMobile(mesContrats);
        GenerateAllQuittances(10);
        print("Sucess quittences");
      },
    );
  }

  Future<void> GetAllQuittancesFiltrer(
      BuildContext context, String? id, String annee, String statut) async {
    final response =
        await quittanceService.GetAllQuittancesFiltrer(id, annee, statut);

    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
      },
      (mesContrats) async {
        myProvider.setListContrats(mesContrats);
        myProvider.setListContratsMobile(mesContrats);
        //GenerateAllQuittances(10);
        print("Sucess quittences");
      },
    );
  }

  GenerateAllQuittances(int n) {
    myProvider.generateContrats(n);
  }
}
