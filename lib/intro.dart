import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Icon(
          Icons.family_restroom,
          size: 100.0,
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20.0),
        Text(
          '메 타 팸 \v v0.1',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
        const SizedBox(height: 60.0),
        ElevatedButton(
              style: ElevatedButton.styleFrom(
            
            
            shadowColor: Colors.greenAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(100, 80), //////// HERE
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/sign-in');
          },
          child: const Text('Firebase Login', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
        ),
        const SizedBox(height: 60.0),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/sign-in');
          },
          child: const Text('누르지마', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
             
            ),
          ),
        ),
        const SizedBox(height: 62.0),
        const Text(
          '메타펨 서비스는 소셜로그인 기능만 제공합니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
