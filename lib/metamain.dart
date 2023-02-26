import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'main.dart';

class MetaMain extends StatelessWidget {
  const MetaMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, child) => ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(255, 197, 232, 90),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  FaceMatching(
                      appState.famlist[appState.currentFamilyIndex].fammood),
                  SizedBox(height: 20),
                  ListTile(
                      title: Text(
                    appState.currentFamily + ' 가족은 여느때와 같이 평온한 하루를 보내고 계십니다',
                    style: TextStyle(color: Color.fromARGB(255, 20, 19, 19)),
                  )),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'rmflt',
                        style: TextStyle(color: Color.fromARGB(255, 34, 2, 2)),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('   Select Member'),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: appState.userslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 20,
                          shape: const CircleBorder(),
                          color: Color.fromARGB(255, 199, 210, 219),
                          child: InkWell(
                              splashColor: Color.fromARGB(255, 195, 220, 209),
                              onTap: () async {
                                _showdialog(
                                    context, appState.userslist[index].name);
                              },
                              child: Column(children: <Widget>[
                                Icon(
                                  Icons.sentiment_satisfied_outlined,
                                  size: 50,
                                ),
                                Text(appState.userslist[index].name)
                              ])));
                    })),
          ),
          SizedBox(height: 30),
          Text('   Select Family'),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: appState.famlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 20,
                          shape: const CircleBorder(),
                          color: Color.fromARGB(255, 233, 208, 81),
                          child: InkWell(
                              splashColor: Colors.amber,
                              onTap: () async {
                                Provider.of<ApplicationState>(context,
                                        listen: false)
                                    .setFamily(index);
                                Provider.of<ApplicationState>(context,
                                        listen: false)
                                    .setFamilyIndex(index);
                              },
                              child: Column(children: <Widget>[
                                FaceMatchingSmall(appState
                                    .famlist[appState.currentFamilyIndex]
                                    .fammood),
                                Text(appState.famlist[index].famname)
                              ])));
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

Widget FaceMatching(String mood) {
  switch (mood) {
    case 'verygood':
      return Icon(Icons.sentiment_very_satisfied_outlined, size: 70);
      break;
    case 'good':
      return Icon(Icons.sentiment_satisfied_outlined, size: 70);
      break;
    case 'normal':
      return Icon(Icons.sentiment_neutral_outlined, size: 70);
      break;
    case 'bad':
      return Icon(Icons.sentiment_dissatisfied_outlined, size: 70);
      break;
    case 'verybad':
      return Icon(Icons.sentiment_very_dissatisfied_outlined, size: 70);
      break;
    default:
      return Icon(Icons.sentiment_neutral_outlined, size: 70);
  }
}

Widget FaceMatchingSmall(String mood) {
  switch (mood) {
    case 'verygood':
      return Icon(Icons.sentiment_very_satisfied_outlined, size: 50);
      break;
    case 'good':
      return Icon(Icons.sentiment_satisfied_outlined, size: 50);
      break;
    case 'normal':
      return Icon(Icons.sentiment_neutral_outlined, size: 50);
      break;
    case 'bad':
      return Icon(Icons.sentiment_dissatisfied_outlined, size: 50);
      break;
    case 'verybad':
      return Icon(Icons.sentiment_very_dissatisfied_outlined, size: 50);
      break;
    default:
      return Icon(Icons.sentiment_neutral_outlined, size: 50);
  }
}

Future<dynamic> _showdialog(BuildContext context, String title) {
  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text('밥 먹을러 갈래?'),
      actions: [
        ElevatedButton(
           
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.favorite_border_outlined),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.pink
                
                ),),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.favorite_border_outlined),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.pink)),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.favorite_border_outlined),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.pink)),
      ],
      elevation: 20.0,
      backgroundColor: Color.fromARGB(255, 193, 228, 223),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
    ),
  );
}
