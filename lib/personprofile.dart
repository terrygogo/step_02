import 'package:flutter/material.dart';

class PersonProfile extends StatefulWidget {
  const PersonProfile({Key? key}) : super(key: key);

  @override
  _PersonProfileState createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  final _formKey = GlobalKey<FormState>();
  String? name = 'nobody';
  String? birthday = ' ';
  String? email =  ' ';
  String? phone= ' ';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("설정"),
            leading: BackButton(),
            centerTitle: true,
            actions: [
              // IconButton(
              //   onPressed: null,
              //   icon: Icon(Icons.settings),
              // )
            ]),
        body: 
        Form( key: _formKey,
        child: ListView(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Text(name!),
                      ]),
                  Row(children: <Widget>[
                    Text(birthday!),
                  ]),
                  Row(children: <Widget>[
                    Text(email!),
                  ]),
                  Row(children: <Widget>[
                    Text(phone!),
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
                TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                const SizedBox(height: 60.0),
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ])
        ])));
  }
}
