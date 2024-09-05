import 'package:flutter/material.dart';

class AttestationProvider extends ChangeNotifier {
  bool erreur = true;
  setErreur(v) {
    erreur = v;
    notifyListeners();
  }
}
