import 'package:flutter/material.dart';

class HeritageScreen extends StatefulWidget {
  const HeritageScreen({super.key});

  @override
  State<HeritageScreen> createState() => _HeritageScreen();
}

 

class _HeritageScreen extends State<HeritageScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    Align(
  alignment: Alignment.topLeft,
  child: Padding(
        padding: const EdgeInsets.all(0),
        child: SizedBox(
       
          height: 50,
          width: double.infinity,
          child:  Card(
              child: Align(
                  alignment: Alignment.centerLeft, child: const Text('헤리티지팸, 디지털 타임 캡슐')),
            ),
          ),
        ));
  }
}
