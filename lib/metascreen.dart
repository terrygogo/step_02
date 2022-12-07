import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class MetaScreen extends StatefulWidget {
  const MetaScreen({super.key});

  @override
  State<MetaScreen> createState() => _MetaScreen();
}

class _MetaScreen extends State<MetaScreen> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Align(
            heightFactor: 1,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text('메타팸, 우리 가족 디지털 공간'),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Consumer<ApplicationState>(
                  builder: (context, appState, _) => Text(appState.xxx)),
            ),
          )
        ],
      )),
    );
  }
}
