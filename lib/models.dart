class User {
  int id = 0;
  String username = "empty";
  String password = "empty";
  User(this.password, this.username);
}

class Articles {
  List<Order> orders;

  Articles({this.orders});

  Articles.fromJson(Map<String, dynamic> json) {
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

  Order(
      {this.orderId,
      this.amount,
      this.screenType,
      this.agencyId,
      this.cityId,
      this.duration,
      this.numberRepeats,
      this.contentURL});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    amount = json['amount'];
    screenType = json['screen_type'];
    agencyId = json['agency_id'];
    cityId = json['city_id'];
    duration = json['duration'];
    numberRepeats = json['number_repeats'];
    //!ContentURL ???----------------
    contentURL = json['content_url'];
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
    return data;
  }
}
