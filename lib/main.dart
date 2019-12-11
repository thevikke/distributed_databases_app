import 'package:distributed_databases_app/components.dart';
import 'package:distributed_databases_app/login_page.dart';
import 'package:distributed_databases_app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

const String finnishFlagURL =
    "https://pngimage.net/wp-content/uploads/2018/06/finnish-flag-png-2.png";
const String spanishFlagURL =
    "https://stuffedeyes.files.wordpress.com/2018/06/spain-2906824_960_720.png?w=748";
const String frenchFlagURL =
    "https://i.ebayimg.com/images/g/11kAAOxyeZNTRnO1/s-l640.jpg";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Distributed Databases Demo',
          home: SelectCountryPage(),
        ));
  }
}

class SelectCountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Country"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ImageButton(() {
              appState.setCountry("Finland");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }, finnishFlagURL, "Finland"),
            ImageButton(() {
              appState.setCountry("Spain");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }, spanishFlagURL, "Spain"),
            ImageButton(() {
              appState.setCountry("France");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }, frenchFlagURL, "France"),
          ],
        ),
      ),
    );
  }
}
