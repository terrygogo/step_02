import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'familyprofile.dart';
import 'humanprofile.dart';
import 'personprofile.dart';
import 'profileedit.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, child) => Scaffold(
            appBar: AppBar(title: const Text("Profile"), actions: [
              IconButton(
                onPressed: null,
                icon: Icon(Icons.settings),
              )
            ]),
            body: ListView(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      // heightFactor: 1,
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text('개인프로필'),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ]),
              Row(children: <Widget>[
                Icon(
                  Icons.face,
                  color: Color.fromARGB(255, 24, 7, 7),
                  size: 120,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('name'),
                          ]),
                      Row(children: <Widget>[
                        Text('birthday'),
                      ]),
                      Row(children: <Widget>[
                        Text('email'),
                      ]),
                      Row(children: <Widget>[
                        Text('phone number'),
                      ])
                    ]),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(appState
                                .userslist[appState.currentFamilyIndex].name),
                          ]),
                      Row(children: <Widget>[
                        Text('1919/03/03'),
                      ]),
                      Row(children: <Widget>[
                        Text('wating@naver.com'),
                      ]),
                      Row(children: <Widget>[
                        Text('010-8788-1234'),
                      ])
                    ])
              ]),
              SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Text('Profile',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 60.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        //minimumSize: const Size(100, 80), //////// HERE
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HumanCompleteForm()),
                        );
                      },
                      child: const Text(
                        'edit',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Text('Family',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 60.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        //minimumSize: const Size(100, 80), //////// HERE
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FamilyCompleteForm()),
                        );
                      },
                      child: const Text(
                        'edit',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80.0),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Text('Authority',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 38.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        //minimumSize: const Size(100, 80), //////// HERE
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                      child: const Text(
                        'edit',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ]),
              const SizedBox(height: 10.0),
              const SizedBox(height: 60.0),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        //minimumSize: const Size(100, 80), //////// HERE
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.greenAccent,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        //minimumSize: const Size(100, 80), //////// HERE
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                      child: const Text(
                        'Sign-Out Metafam',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ])
            ])));
  }
}
