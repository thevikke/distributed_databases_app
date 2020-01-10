import 'package:distributed_databases_app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController durationController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin page"),
        ),
        body: Consumer<AppState>(
          builder: (_, appState, __) => Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Location: (FRA,FI,SPA)"),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: locationController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              durationController.clear();
                              appState.setLocation((value));
                            }
                          },
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Or"),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Duration: (Numbers)"),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: durationController,
                          onChanged: (value) {
                            locationController.clear();
                            if (value.isNotEmpty) {
                              appState.setDuration(int.parse(value));
                            }
                          },
                        ),
                      )),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Search reports",
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          appState.loadReports();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: appState.reports.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                  "Agency name: ${appState.reports[index].agencyName}"),
                              Text(
                                  "Agency id: ${appState.reports[index].agencyId}"),
                              Text(
                                  "Location: ${appState.reports[index].location}"),
                              appState.reports[index].sumDuration != null
                                  ? Text(
                                      "Sum of duration: ${appState.reports[index].sumDuration}")
                                  : Container(),
                              appState.reports[index].amount != null
                                  ? Text(
                                      "Amount of orders: ${appState.reports[index].amount}")
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
