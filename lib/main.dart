import 'package:distributed_databases_app/components.dart';
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
        backgroundColor: Colors.pink,
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

class LoginPage extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  String username = "", password = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Login"),
      ),
      body: Center(
        child: AnimatedCrossFade(
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
            height: MediaQuery.of(context).size.height / 3,
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
                          appState.logIn(username, password);
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
    );
  }
}

class BuildAdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppState>(
          builder: (context, appState, child) => Text(appState.country),
        ),
      ),
      body: Container(
        child: Center(
          child: MyCustomForm(),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  List<bool> _selectionsScreenSize = List.generate(3, (_) => false);
  List<bool> _selectionsDaysHours = List.generate(2, (_) => false);
  List<bool> _selectionsAds = List.generate(5, (_) => false);
  final List<String> _adsDataList = [
    "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/11/21/11/ramsay-cass-beer.png",
    "https://dmrqkbkq8el9i.cloudfront.net/Pictures/480xany/4/5/9/168459_countrylifebuttertheresamayadvert_892560_crop.jpg",
    "https://d3bzyjrsc4233l.cloudfront.net/cache/57/cd/57cdb9941612f4aeb20b732ee7d4abc9.jpg",
    "https://adverts-group.com/wp-content/uploads/2017/05/tav-ads-may-ads-en.png",
    "https://d1e4pidl3fu268.cloudfront.net/567dc4ea-e383-4c32-ad75-1e4246ca7fdc/Advertsle1.crop_509x382_0,235.preview.png"
  ];
  int _selectedIndex = 0;
  @override
  void initState() {
    _selectionsScreenSize[0] = true;
    _selectionsDaysHours[0] = true;
    _selectionsAds[0] = true;
    super.initState();
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Row(
      children: <Widget>[
        Container(
          child: ListView.builder(
            padding: EdgeInsets.all(40),
            itemCount: _adsDataList.length,
            itemBuilder: (context, index) => Container(
              color: _selectedIndex != null && _selectedIndex == index
                  ? Colors.green
                  : Colors.white,
              child: ListTile(
                title: Image.network(_adsDataList[index]),
                onTap: () => _onSelected(index),
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width / 2,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ToggleButtons(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.tv,
                          size: 300,
                        ),
                        Text(
                          "Billboard",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.tv,
                          size: 200,
                        ),
                        Text(
                          "Standing",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.tv,
                          size: 100,
                        ),
                        Text(
                          "Small",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _selectionsScreenSize.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selectionsScreenSize[buttonIndex] = true;
                        } else {
                          _selectionsScreenSize[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: _selectionsScreenSize,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Show time in Hours or Days'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleButtons(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.view_day,
                                size: 80,
                              ),
                              Text(
                                "Days",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.hourglass_full,
                                size: 80,
                              ),
                              Text(
                                "Hours",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          )
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < _selectionsDaysHours.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _selectionsDaysHours[buttonIndex] = true;
                              } else {
                                _selectionsDaysHours[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: _selectionsDaysHours,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Number of repeats/Hour"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Processing Data'),
                          backgroundColor: Colors.green,
                        ));
                      }
                    },
                    child: Text('Create Ad'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
