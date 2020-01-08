import 'package:distributed_databases_app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Consumer<AppState>(
        builder: (_, state, __) => Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    width: 100,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Order_id: ${state.orders[index].orderId}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("Agency_id: ${state.orders[index].agencyId}",
                              style: TextStyle(fontSize: 20)),
                          Text("Screen_type: ${state.orders[index].screenType}",
                              style: TextStyle(fontSize: 20)),
                          Text("Duration: ${state.orders[index].duration}",
                              style: TextStyle(fontSize: 20)),
                          Text("Start time of playing: ",
                              style: TextStyle(fontSize: 20)),
                          Text("Cost: ${state.orders[index].amount}",
                              style: TextStyle(fontSize: 20)),
                          //! URL
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
