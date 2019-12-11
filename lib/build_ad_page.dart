import 'package:distributed_databases_app/ad_player_page.dart';
import 'package:distributed_databases_app/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state.dart';

class BuildAdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            Consumer<AppState>(
              builder: (_, appState, __) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Country: ${appState.country}\nUsername: ${appState.user.username}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
          title: Row(
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Orders",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrdersPage(),
                    ),
                  );
                },
              ),
              FlatButton(
                child: Text(
                  "AD player",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdPlayerPage(),
                    ),
                  );
                },
              )
            ],
          )),
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
          padding: EdgeInsets.all(30),
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
