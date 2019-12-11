import 'package:flutter/material.dart';

class AdPlayerPage extends StatelessWidget {
  const AdPlayerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 2,
          child: Image.network(
              "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/11/21/11/ramsay-cass-beer.png"),
        ),
      ),
    );
  }
}
