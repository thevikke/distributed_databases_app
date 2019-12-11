import 'package:distributed_databases_app/models.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String country = "empty";
  bool loginState = false;
  bool loading = false;
  User user;

  void setCountry(String newCountry) {
    country = newCountry;
    print(newCountry);
    notifyListeners();
  }

  void logIn(String username, String password) {
    print("Login called with:$username $password");
    loading = true;
    Future.delayed(Duration(seconds: 3));
    loginState = true;
    notifyListeners();
  }
}
