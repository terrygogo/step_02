import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

// ignore: must_be_immutable
class BodyTemplate extends StatelessWidget {
  String sectiontitle;
  BodyTemplate(this.sectiontitle, this.sectionscreen, {super.key});

  Widget sectionscreen;

  @override
  Widget build(BuildContext context) {
    return   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
           // heightFactor: 1,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(sectiontitle),
            ),
          ),
   
          Expanded(child:  Consumer<ApplicationState>(
                  builder: (context, appState, _) => sectionscreen,
                ),)
              
        ],
      );
    
  }
}
