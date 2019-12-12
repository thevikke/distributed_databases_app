import 'package:distributed_databases_app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdPlayerPage extends StatelessWidget {
  const AdPlayerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer<AppState>(
          builder: (_, state, __) => Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 2,
            child: Image.network(state.selectedAd),
          ),
        ),
      ),
    );
  }
}
