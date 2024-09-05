import 'package:flutter/material.dart';
import 'package:espace_client/Constants.dart' as constants;
import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String titre;
  final String sousTitre;

  const ErrorPage({super.key, required this.titre, required this.sousTitre});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titre,
                  style: TextStyle(color: constants.MyGreyColor2, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sousTitre,
                  style: TextStyle(color: constants.MyGreyColor2, fontSize: 18),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Action pour réessayer
                },
                icon: Icon(
                  Icons.refresh,
                  color: constants.defaultBackgroundColor,
                ),
                label: Text(
                  'Veuillez réessayer',
                  style: TextStyle(
                      color: constants.defaultBackgroundColor, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Couleur du bouton
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
