import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distributed Databases Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectCountry(),
    );
  }
}

class SelectCountry extends StatefulWidget {
  SelectCountry({Key key}) : super(key: key);

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select country"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text("Finland"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CountryPage("Finland");
                }));
              },
            ),
            FlatButton(
              color: Colors.orange,
              child: Text("Spain"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CountryPage("Spain");
                }));
              },
            ),
            FlatButton(
              color: Colors.red,
              child: Text("France"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CountryPage("France");
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}

class CountryPage extends StatefulWidget {
  CountryPage(this.country, {Key key}) : super(key: key);
  final String country;
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(widget.country),
        ),
      ),
    );
  }
}
