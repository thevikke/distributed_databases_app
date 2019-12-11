import 'package:distributed_databases_app/models.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String country = "empty";
  bool loginState = false;
  bool loading = false;
  User user;

  void setCountry(String newCountry) {
    country = newCountry;

    notifyListeners();
  }

  Future<void> logIn(String username, String password) async {
    user = User(username, password);
    loading = true;
    notifyListeners();

    await new Future.delayed(const Duration(seconds: 2));

    loading = false;
    loginState = true;
    notifyListeners();
  }
}
