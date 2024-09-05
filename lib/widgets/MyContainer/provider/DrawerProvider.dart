import 'package:espace_client/utils/ErrorPage.dart';
import 'package:espace_client/widgets/AcceuilPage/Views/AcceuilView.dart';
import 'package:espace_client/widgets/QuittancePage/Views/quittancePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  int selectedItemIndex = 0;

  int get GetSelectedItemIndex {
    return selectedItemIndex;
  }

  void setSelectedItemIndex(x) {
    selectedItemIndex = x;
    notifyListeners();
    print(selectedItemIndex);
  }

  void resetDrawerProvider() {
    selectedItemIndex = 0;
    notifyListeners();
  }
}
