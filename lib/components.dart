import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton(this.onTap, this.imageURL, this.title);
  final Function onTap;
  final String imageURL;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          child: InkWell(
            onTap: onTap,
            child: Image.network(imageURL),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
