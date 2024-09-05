import 'package:dartz/dartz.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/core/Errors/exceptions.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';

class LoginService {
  final DioConsumer api;
  LoginService({required this.api});

  Future<Either<String, String>> GetAcessToken() async {
    Map<String, dynamic> mapHeader = {
      ApiKey.apiKey: ApiKey.apiValue,
    };

    try {
      // faire requete et récupèrer la reponse
      final response = await api.post(
        EndPoint.loginEndPoint,
        isFromData: false,
        mapHeader: mapHeader,
      );
      // prendre le nécèssaire de la réponse
      print(response[ApiKey.token]);
      // enregistrer le token
      await MySharedPrefrences()
          .saveData(key: ApiKey.token, value: response[ApiKey.token]);

      // retourner le token en cas de sucess
      return Right(response[ApiKey.token]);
    } on ServerException catch (e) {
      // en cas d'erreur , le serveur gère les execption
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, Map<String, dynamic>>> testMail(
      {required mail, required token}) async {
    try {
      // preparer map for query et header param
      Map<String, dynamic> mapQuerry = {ApiKey.adresse_mail: mail};
      Map<String, dynamic> mapHeader = {
        ApiKey.idSession: MySharedPrefrences().getData(key: ApiKey.token)
      };
      // lancer la requète get
      final response = await api.get(
        EndPoint.loginEndPoint,
        queryParameters: mapQuerry,
        mapHeader: mapHeader,
      );
      print(response);
      // mapper la réponse et la retourner
      Map<String, dynamic> mapResult = {
        ApiKey.error: response[ApiKey.error],
        ApiKey.key: response[ApiKey.key],
        ApiKey.email: response[ApiKey.email],
        ApiKey.message: response[ApiKey.message],
      };

      return Right(mapResult);
    } on ServerException catch (e) {
      print(e.toString());
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, Map<String, dynamic>>> HandleLoginUser({
    required String email,
    required String password,
    required String key,
  }) async {
    try {
      // faire requete et récupèrer la reponse
      final response = await api.get(
        EndPoint.register_or_checkEndPoint,
        queryParameters: {
          ApiKey.adresse_mail: email,
          ApiKey.password: password,
          ApiKey.key: key,
        },
      );
      print(response["data"][0]["name"]);
      Map<String, dynamic> mapResult = {
        ApiKey.error: response[ApiKey.error],
        ApiKey.id: response[ApiKey.id],
        ApiKey.message: response[ApiKey.message],
        ApiKey.userName: response["data"][0]["name"],
      };
      await MySharedPrefrences()
          .saveData(key: ApiKey.id, value: response[ApiKey.id]);

      // retourner le token en cas de sucess
      return Right(mapResult);
    } on ServerException catch (e) {
      // en cas d'erreur , le serveur gère les execption
      return Left(e.errModel.errorMessage);
    }
  }
}
