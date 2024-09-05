import 'package:dio/dio.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/utils/CustomToast.dart';
import 'package:espace_client/utils/ErrorPage.dart';
import 'package:espace_client/widgets/AttestationPage/Provider/AttestationProvider.dart';
import 'package:espace_client/widgets/AttestationPage/Service/AttestationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:espace_client/Constants.dart' as constants;

class AttestationController {
  BuildContext context;
  // instance service
  final attestationService = AttestationService(api: DioConsumer(dio: Dio()));
  // instance provider
  var myProvider;

  // login controlleur
  AttestationController({
    required this.context,
  }) {
    myProvider = Provider.of<AttestationProvider>(context, listen: false);
  }

  Future<List<String>> GetAllmyAttestations(String? id,
      {required BuildContext context}) async {
    final response = await attestationService.GetAllmyAttestations(id);

    response.fold(
      (errMessage) {
        print(errMessage);
        CustomFlushbar.showFlushbar(context, errMessage,
            backgroundColor: constants.ButtonColor);
        Provider.of<AttestationProvider>(context, listen: false)
            .setErreur(true);
      },
      (token) async {
        print("sucess Attestations");
      },
    );
    return ([]);
  }
}
