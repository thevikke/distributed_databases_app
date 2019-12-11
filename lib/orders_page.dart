import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Text(
                      index.toString(),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
