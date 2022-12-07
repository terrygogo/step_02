import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class MetaMain extends StatelessWidget {
  const MetaMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, child) => Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.green,
              elevation: 10,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Icon(Icons.sentiment_very_satisfied_outlined, size: 70),
                  SizedBox(height: 20),
                  ListTile(
                      title: Text(
                    ' 가족은 여느때와 같이 평온한 하루를 보내고 계십니다',
                    style: TextStyle(color: Colors.white),
                  )),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                         'rmflt',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: appState.userslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 20,
                          shape: const CircleBorder(),
                          color: Colors.blue[100],
                          child: Column(children: <Widget>[
                            Icon(
                              Icons.sentiment_satisfied_outlined,
                              size: 50,
                            ),
                            Text(appState.userslist[index].name)
                          ]));
                    })),
          ),
        ],
      ),
    );
  }
}


/*

@override
Widget build(BuildContext context) {
  return Consumer<ApplicationState>(
      builder: (context, appState, child) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: ListTile(
                  leading: Icon(
                    Icons.sentiment_very_satisfied_outlined,
                    size: 50,
                  ),
                  title: Text(appState.famlists[0].famname),
                  subtitle: Text(appState.famlists[0].message),
                )),
                for (var users in appState.userslist)
                  ListTile(
                    leading: Icon(Icons.sentiment_neutral),
                    title: Text(users.name),
                    subtitle: Text(users.message),
                  ),
              ],
            ),
          ));
}
*/
/*
@override
Widget build(BuildContext context) {
  return Consumer<ApplicationState>(
    builder: (context, appState, child) => Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.green,
            elevation: 10,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Icon(Icons.sentiment_very_satisfied_outlined, size: 70),
                SizedBox(height: 20),
                ListTile(
                    title: Text(
                  appState.myfam!.famname + ' 가족은 여느때와 같이 평온한 하루를 보내고 계십니다',
                  style: TextStyle(color: Colors.white),
                )),
                SizedBox(height: 30),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      appState.myfam!.message,
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
        for (var users in appState.userslist)
          ListTile(
            leading: Icon(Icons.sentiment_neutral),
            title: Text(users.name),
          ),
      ],
    ),
  );
}
*/
