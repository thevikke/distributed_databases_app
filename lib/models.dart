import 'dart:convert';

class User {
  int id = 0;
  String username = "empty";
  String password = "empty";
  User(this.password, this.username);
}

class Orders {
  List<Order> orders;

  Orders({this.orders});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Order>();
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// So when you make an ad order is created for it. Basically ad is same as Order at this point of time.
class Order {
  int orderId;
  double amount;
  String screenType;
  String contentURL;
  int agencyId;
  int cityId;
  int duration;
  int numberRepeats;
  int screenId;
  int price;
  DateTime time;

  Order(
      {this.orderId = 0,
      this.amount = 0,
      this.screenType = "",
      this.agencyId = 0,
      this.cityId = 0,
      this.duration = 0,
      this.numberRepeats = 0,
      this.contentURL = " ",
      this.screenId = 0,
      this.price = 0,
      this.time});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    amount = json['amount'];
    screenType = json['screen_type'];
    agencyId = json['agency_id'];
    cityId = json['city_id'];
    duration = json['duration'];
    numberRepeats = json['number_of_repeat'];
    //!ContentURL ???----------------
    contentURL = json['content_url'];
    screenId = json['screenId'];
    price = json['price'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['screen_type'] = this.screenType;
    data['agency_id'] = this.agencyId;
    data['city_id'] = this.cityId;
    data['duration'] = this.duration;
    data['number_repeats'] = this.numberRepeats;
    data['content_url'] = this.contentURL;
    data['time'] = this.time;
    return data;
  }
}

class Screen {
  String type;
  int screenId;
  int price;
  int cityId;

  Screen({this.type, this.screenId, this.price, this.cityId});

  Screen.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    screenId = json['screen_id'];
    price = json['price'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['screen_id'] = this.screenId;
    data['price'] = this.price;
    data['city_id'] = this.cityId;
    return data;
  }
}

List<Report> reportFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  double sumDuration;
  String agencyName;
  String location;
  int agencyId;
  int amount;

  Report(
      {this.sumDuration,
      this.agencyName,
      this.location,
      this.agencyId,
      this.amount});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      sumDuration: json["sum"],
      agencyName: json["agency_name"],
      location: json["location"],
      agencyId: json["agency_id"],
      amount: json["amount"]);

  Map<String, dynamic> toJson() => {
        "sum": sumDuration,
        "agency_name": agencyName,
        "location": location,
        "agency_id": agencyId,
        "amount": amount
      };
}
