import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String country = "empty";

  void setCountry(String newCountry) {
    country = newCountry;
    print(newCountry);
    notifyListeners();
  }
}
