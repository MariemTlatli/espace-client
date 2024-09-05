import 'package:espace_client/widgets/AcceuilPage/Model/Priorite.dart';
import 'package:flutter/material.dart';

class AcceuilProvider extends ChangeNotifier {
  List<Priorite> listePriorites = [];

  setListPriorites(v) {
    listePriorites = v;
    notifyListeners();
  }

  void printPriorities(List<Priorite> l) {
    for (var priorite in l) {
      print(
          'ID: ${priorite.id}, Libelle: ${priorite.libelle}, Color: ${priorite.color}, Icon: ${priorite.icon}');
    }
  }

  void clearAcceuilProvider() {
    listePriorites = [];
    notifyListeners();
  }
}
