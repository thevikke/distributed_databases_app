import 'dart:io';

import 'package:distributed_databases_app/models.dart';
import 'package:distributed_databases_app/orders_page.dart';
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState with ChangeNotifier {
  String country = "empty";
  bool loginState = false;
  bool loading = false;
  User user;
  Order newOrder;
  List<Screen> screens = List<Screen>();
  List<Order> orders = List<Order>();
  String selectedAd =
      "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/11/21/11/ramsay-cass-beer.png";
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
        await loadScreens();
        var jsonObject = json.decode(response.body);
        user.id = jsonObject["id"];
        loginState = true;
      }
    } catch (e) {
      print(e);
    }
    loading = false;

    notifyListeners();
  }

  Future<void> loadOrders() async {
    var response = await http.get(
        "https://dooh.herokuapp.com/orders?agency_id=${user.id}&country_code=$country");

    try {
      if (response.statusCode == 200) {
        List json = jsonDecode(response.body);
        json.forEach((orderJson) {
          orders.add(new Order.fromJson(orderJson));
        });
        // orders.forEach((order) {
        //   print(order.orderId);
        // });
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> loadScreens() async {
    var response = await http
        .get("https://dooh.herokuapp.com/screens?country_code=$country");
    var json = jsonDecode(response.body);
    json.forEach((v) {
      screens.add(new Screen.fromJson(v));
    });
  }

  Future<void> createAd(Order newOrder, BuildContext context) async {
    // print(
    //     "---${newOrder.agencyId}\n---${newOrder.cityId}\n---${newOrder.orderId}\n---${newOrder.amount}\n---${newOrder.duration}\n---${newOrder.screenType}\n---${newOrder.numberRepeats}\n---${newOrder.contentURL}");

    screens.forEach((screen) {
      if (screen.type == newOrder.screenType) {
        newOrder.screenId = screen.screenId;
        newOrder.price = screen.price;
      }
    });

    var response = await http.post(
        "https://dooh.herokuapp.com/new_order?screen_id=1&country_code=$country&duration=${newOrder.duration}&number_of_repeat=${newOrder.numberRepeats}&price=${newOrder.price}&agency_id=${user.id}&screen_type=${newOrder.screenType}&city_id=1");

    try {
      if (response.statusCode == 200) {
        selectedAd = newOrder.contentURL;
        await loadOrders();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OrdersPage()));
      }
    } catch (e) {
      print(e);
    }
  }
}
