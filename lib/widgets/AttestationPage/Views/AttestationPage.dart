import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/utils/ErrorPage.dart';
import 'package:espace_client/widgets/AttestationPage/Controller/AttestationController.dart';
import 'package:flutter/material.dart';

class AttestationPage extends StatefulWidget {
  const AttestationPage({super.key});

  @override
  State<AttestationPage> createState() => _AttestationPageState();
}

class _AttestationPageState extends State<AttestationPage> {
  late Future<List<String>> _futureAttestations;

  @override
  void initState() {
    super.initState();
    AttestationController myAttestationController =
        AttestationController(context: context);

    _futureAttestations = myAttestationController.GetAllmyAttestations(
      MySharedPrefrences.sharedPreferences.getString(ApiKey.id)!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _futureAttestations,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un indicateur de chargement pendant que les données sont en cours de récupération
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Afficher une page d'erreur en cas de problème
          return Center(
            child: ErrorPage(
              titre: "Quelque chose s'est mal passé",
              sousTitre: 'Veuillez réessayer plus tard',
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Afficher un message si aucune donnée n'est disponible
          return Center(
            child: ErrorPage(
              titre: "Quelque chose s'est mal passé",
              sousTitre: 'Veuillez réessayer plus tard',
            ),
          );
        } else {
          // Afficher les données lorsqu'elles sont disponibles
          return Center(child: Text('Mes Attestations'));
          /*List<String> attestations = snapshot.data!;
          return ListView.builder(
            itemCount: attestations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(attestations[index]), // Afficher chaque attestation
              );
            },
          );*/
        }
      },
    );
  }
}
