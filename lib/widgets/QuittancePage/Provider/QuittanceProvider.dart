import 'dart:math';

import 'package:espace_client/widgets/QuittancePage/Models/Contrat.dart';
import 'package:flutter/material.dart';

class QuittanceProvider extends ChangeNotifier {
  late List<Contrat> mesContrats = [];
  late List<Contrat> mesContratsMobile = [];
  int nbContrats = 1;

  String annee = "2024";
  String statut = "PLANIFIE";

  void setListContratsMobile(v) {
    mesContratsMobile = v;
    nbContrats = mesContrats.length;
    notifyListeners();
  }

  void setListContrats(v) {
    mesContrats = v;
    nbContrats = mesContrats.length;
    notifyListeners();
  }

  void AddListContrats(v) {
    mesContrats.addAll(v);
    notifyListeners();
  }

  int GetNbContrats() {
    nbContrats = mesContrats.length;
    notifyListeners();
    return nbContrats;
  }

  List<Contrat> generateContrats(int count) {
    final random = Random();
    List<Contrat> maList = List.generate(count, (index) {
      return Contrat(
        numeroContrat: 'ID${index + 1}',
        primeContrat: '\$${(index + 1) * 1000.0}',
        datePayementContrat: DateTime.now()
            .subtract(Duration(days: random.nextInt(30)))
            .toLocal()
            .toString()
            .split(' ')[0],
        statueContrat: random.nextBool() ? 'Paid' : 'Unpaid',
        telechargerContrat: 'Download',
      );
    });
    AddListContrats(maList);
    return (maList);
  }

  void resetQuittanceData() {
    mesContrats = [];
    nbContrats = 0;
    notifyListeners();
  }

  setAnnee(n) {
    annee = n;
    print(annee);
    notifyListeners();
  }

  setStatut(n) {
    statut = n;
    print(statut);
    notifyListeners();
  }
}
