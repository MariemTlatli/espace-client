import 'package:dartz/dartz.dart';
import 'package:espace_client/core/Api/DioConsumer.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/core/Errors/exceptions.dart';
import 'package:espace_client/widgets/CorbeilleTest/quittancePageWithRefresh.dart';

class AttestationService {
  final DioConsumer api;
  AttestationService({required this.api});

  Future<Either<String, List<dynamic>>> GetAllmyAttestations(id) async {
    try {
      // preparer map for query et header param
      Map<String, dynamic> mapQuerry = {
        "nom_produit": "",
        "nbpage": "1",
        "type_contrat": "",
        "itemperpage": "1",
      };

      // lancer la requète get
      final response = await api.get(
        EndPoint.getAttestations(id),
        queryParameters: mapQuerry,
      );

      return Right([]);
    } on ServerException catch (e) {
      print(e.toString());

      return Left(e.errModel.errorMessage);
    }
  }
}
