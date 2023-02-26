import 'package:flutter/material.dart';

import 'appusage.dart';

class SecretScreen extends StatefulWidget {
  const SecretScreen({super.key});

  @override
  State<SecretScreen> createState() => _SecretScreen();
}

class _SecretScreen extends State<SecretScreen> {
  @override
  Widget build(BuildContext context) {
    return AppUsage();
    /*
  Align(
        alignment: Alignment.topLeft,
 
        child: 
          
           Card(
            child: Column(
              mainAxisAlignment : MainAxisAlignment.start,
              children: const <Widget>[
                Align(
                  heightFactor: 1,
                  alignment: Alignment.topLeft, 
                  child: Padding(
                      padding:   EdgeInsets.only(left: 15, top: 10),
                         child:   Text('시크릿팸, 나를 정리하는 비밀노트'),
             ),
            ),
            SizedBox( height: 10),
            Align(
                 
                  alignment: Alignment.centerLeft, 
                  child: Padding(
                      padding: EdgeInsets.all( 0),
                        child:   AppUsage()),
             ),
            
           
            ],)
          ),
        ); */
  }
}
