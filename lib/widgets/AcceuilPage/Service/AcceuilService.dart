import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/core/Errors/exceptions.dart';
import 'package:espace_client/widgets/AcceuilPage/Model/Priorite.dart';

class AcceuilService {
  final DioConsumer api;
  AcceuilService({required this.api});

  Future<Either<String, List<Priorite>>> getListPriorites() async {
    try {
      List<Priorite> items = [];
      // faire requete et récupèrer la reponse
      final response = await api.get(
        EndPoint.list_priorite,
        isFromData: false,
      );

      List<dynamic> data = response['data'];
      items = data.map((itemJson) => Priorite.fromJson(itemJson)).toList();

      return Right(items);
    } on ServerException catch (e) {
      // en cas d'erreur , le serveur gère les execption
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, dynamic>> getListTaches(id) async {
    try {
      // faire requete et récupèrer la reponse
      final response = await api.get2(
        EndPoint.getList(id),
        isFromData: false,
      );
      // prendre le nécèssaire de la réponse
      /*    List<dynamic> data = response['data'];
      items = data.map((itemJson) => Priorite.fromJson(itemJson)).toList();
*/
      print(response.runtimeType);
      return Right(response);
    } on ServerException catch (e) {
      // en cas d'erreur , le serveur gère les execption
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, String>> getListStatusAffaire() async {
    try {
      // faire requete et récupèrer la reponse
      final response = await api.get(
        EndPoint.list_status_affaires,
        isFromData: false,
      );
      // prendre le nécèssaire de la réponse
      //print(response.toString());

      return Right(response);
    } on ServerException catch (e) {
      // en cas d'erreur , le serveur gère les execption
      return Left(e.errModel.errorMessage);
    }
  }
}
