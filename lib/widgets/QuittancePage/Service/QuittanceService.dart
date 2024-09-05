import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/core/Errors/exceptions.dart';
import 'package:espace_client/widgets/QuittancePage/Models/Contrat.dart';

class QuittanceService {
  final DioConsumer api;
  QuittanceService({required this.api});

  Future<Either<String, List<Contrat>>> GetAllQuittances(id) async {
    try {
      // preparer map for query et header param
      Map<String, dynamic> mapQuerry = {
        ApiKey.limit: 1,
        ApiKey.page: 1,
        ApiKey.annee: "",
        ApiKey.num_contrat: "",
        ApiKey.status: "",
      };

      // lancer la requète get
      final response = await api.get(
        EndPoint.getQuittances(id),
        queryParameters: mapQuerry,
      );
      print(response.runtimeType);
      print(response[0]["echeances"][0]["status"]);
      print(response[0]["echeances"][0]["status"].runtimeType);
      print(response[0]["echeances"][0]["montant"].runtimeType);
      print(response[0]["echeances"][0]["date_prelevement"].runtimeType);
      List<Contrat> maListe = Contrat.parseContrats(response);

      return Right(maListe);
    } on ServerException catch (e) {
      print(e.toString());
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, List<Contrat>>> GetAllQuittancesFiltrer(
      id, annee, statut) async {
    try {
      // preparer map for query et header param
      Map<String, dynamic> mapQuerry = {
        ApiKey.limit: 1,
        ApiKey.page: 1,
        ApiKey.annee: annee,
        ApiKey.num_contrat: "",
        ApiKey.status: statut,
      };

      // lancer la requète get
      final response = await api.get(
        EndPoint.getQuittances(id),
        queryParameters: mapQuerry,
      );
      print(response.runtimeType);
      print(response[0]["echeances"][0]["status"]);
      print(response[0]["echeances"][0]["status"].runtimeType);
      print(response[0]["echeances"][0]["montant"].runtimeType);
      print(response[0]["echeances"][0]["date_prelevement"].runtimeType);
      List<Contrat> maListe = Contrat.parseContrats(response);

      return Right(maListe);
    } on ServerException catch (e) {
      print(e.toString());
      return Left(e.errModel.errorMessage);
    }
  }
}
