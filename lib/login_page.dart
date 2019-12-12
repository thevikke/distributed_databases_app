import 'package:distributed_databases_app/build_ad_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state.dart';

class LoginPage extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  String username = "", password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Consumer<AppState>(
          builder: (_, appState, __) => AnimatedCrossFade(
            crossFadeState: appState.loading
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 250),
            firstChild: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            secondChild: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 40, color: Colors.pink),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username:"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        username = value;
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password:"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        password = value;
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_loginFormKey.currentState.validate()) {
                            appState.logIn(username, password).then((_) {
                              if (appState.loginState == true) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BuildAdPage()),
                                );
                              }
                            });
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
