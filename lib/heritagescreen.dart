import 'package:flutter/material.dart';

import 'appusage.dart';
import 'geousage.dart';
import 'userprofile.dart';

class HeritageScreen extends StatefulWidget {
  const HeritageScreen({super.key});

  @override
  State<HeritageScreen> createState() => _HeritageScreen();
}

class _HeritageScreen extends State<HeritageScreen> {
  @override
  Widget build(BuildContext context) {
    return GeoLocatorWidget();
  }
}
