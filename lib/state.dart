import 'dart:io';

import 'package:distributed_databases_app/models.dart';
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const orders_URL = "";

class AppState with ChangeNotifier {
  String country = "empty";
  bool loginState = false;
  bool loading = false;
  User user;
  Order newOrder;

  void setCountry(String newCountry) {
    country = newCountry;

    notifyListeners();
  }

  Future<void> logIn(String username, String password) async {
    user = User(username, password);
    loading = true;
    notifyListeners();

    var response = await http.post(
        "https://dooh.herokuapp.com/login?username=${user.username}&password=${user.password}",
        headers: {
          "Accept": "*/*",
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        });

    try {
      if (response.statusCode == 200) {
        var jsonObject = json.decode(response.body);
        user.id = jsonObject["id"];
        loginState = true;
      }
    } catch (e) {
      print(e);
    }
    loading = false;
    print(user.id);
    notifyListeners();
  }

  // Future<List<Order>> loadOrders() async{
  //   List<Order> orders;
  //   var response = await http.get("$orders_URL");

  //   try{
  //     if(response.statusCode == 200)
  //     {

  //     }
  //   }
  //   catch(e)
  //   {

  //   }
  // return
  // }

  Future<void> createAd(Order newOrder) async {
    print(
        "---${newOrder.agencyId}\n---${newOrder.cityId}\n---${newOrder.orderId}\n---${newOrder.amount}\n---${newOrder.duration}\n---${newOrder.screenType}\n---${newOrder.numberRepeats}\n---${newOrder.contentURL}");
  }
}
