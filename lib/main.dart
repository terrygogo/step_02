import 'dart:async'; // new

import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new

import 'bodytemplate.dart';
import 'ddayscreen.dart';
import 'heritagescreen.dart';
import 'intro.dart';
import 'metamain.dart';
import 'secretscreen.dart';
import 'src/authentication.dart'; // new
import 'src/widgets.dart';
import 'userprofile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(), child: const App()),
    // builder: ((context, child) => const App()),
  );
}

class GuestBookMessage {
  GuestBookMessage({required this.name, required this.message});
  final String name;
  final String message;
}

Future<bool> isUserLoggedIn() async {
  final User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  late String initPage;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User currentUser;

  @override
  void initState() {
    super.initState();
    try {
      currentUser = auth.currentUser!;
      if (currentUser != null) {
        initPage = '/home';
        /*
      here id is static variable which declare as a page name.
       */
      } else {
        initPage = '/sign-in';
      }
    } catch (e) {
      initPage = '/intro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Start adding here
      initialRoute: initPage,
      routes: {
        '/home': (context) {
          return const MyStatefulWidget();
        },
        '/intro': (context) {
          return const IntroScreen();
        },
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              })),
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {
          return ProfileScreen(
            providers: [],
            actions: [
              SignedOutAction(
                ((context) {
                  Navigator.of(context).pushReplacementNamed('/intro');
                }),
              ),
            ],
          );
        })
      },
      // end adding here
      title: 'Firebase Meetup',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.deepPurple,
            ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Firebase Meetup'),
              ),
              body: ListView(
                children: <Widget>[
                  Image.asset('assets/codelab.png'),
                  const SizedBox(height: 8),
                  const IconAndDetail(Icons.calendar_today, 'October 30'),
                  const IconAndDetail(Icons.location_city, 'San Francisco'),
                  // Add from here
                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => AuthFunc(
                        loggedIn: appState.loggedIn,
                        signOut: () {
                          FirebaseAuth.instance.signOut();
                        }),
                  ),
                  // to here
                  const Divider(
                    height: 8,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey,
                  ),
                  const Header("What we'll be doing"),
                  const Paragraph(
                    'Join us for a day full of Firebase Workshops and Pizza!',
                  ),

                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (appState.loggedIn) ...[
                          const Header('Discussion'),
                          GuestBook(
                            addMessage: (message) =>
                                appState.addMessageToGuestBook(message),
                            messages: appState.guestBookMessages, // new
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    BodyTemplate('메타팸, 우리 가족 디지털 공간', MetaMain()),
    SecretScreen(),
    TalkScreen(),
    BodyTemplate('펨데이, 우리 가족 기념일 관리', TableEventsExample()),
    BodyTemplate('헤리티지펨', HeritageScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<ApplicationState>(context).currentFamily =
    //    Provider.of<ApplicationState>(context)._famlist[0].famname;
    // Provider.of<ApplicationState>(context).currentUser =
    //   FirebaseAuth.instance.currentUser!.displayName!;

    // check current user exist on ptofile list
    // if not create popup
    // if exist load to current
    //final FirebaseAuth auth = FirebaseAuth.instance;
    //Provider.of<ApplicationState>(context).setCurrentUser(auth.currentUser.toString());
  }

  @override
  Widget build(BuildContext context) {
    //final String? abc = FirebaseAuth.instance.currentUser!.displayName;

    return Consumer<ApplicationState>(
        builder: (context, appState, child) => Scaffold(
              appBar: AppBar(
                title: Text(appState.currentUser + '\'s Fam'),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.alarm,
                        color: Colors.white,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CardPage()),
                        );
                        ;
                      }),
                  PopupMenuButton<Text>(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: StyledButton(
                              onPressed: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    barrierColor: Colors.black45,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (BuildContext buildContext,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              10,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              80,
                                          padding: EdgeInsets.all(20),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              StyledButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: const Text('내 프필 설정')),
                        ),
                        PopupMenuItem(
                          child: StyledButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/profile');
                              },
                              child: const Text('account')),
                        ),
                      ];
                    },
                  )
                ],
              ),
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.family_restroom),
                    label: 'Meta',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.security),
                    label: 'Secret',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.phone_in_talk),
                    label: 'Talk',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'D-day',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wallet_giftcard),
                    label: 'Heritage',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                unselectedItemColor: Colors.green[800],
                backgroundColor: Colors.grey[190],
                onTap: _onItemTapped,
              ),
            ));
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 8),
        child: StyledButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/sign-in');
            },
            child: const Text('RSVP')));
  }
}

class UserEntry {
  UserEntry({required this.name, required this.email, required this.phone, required this.birthday});
  String name;
  String email;
  String phone;
  String birthday;
 
}

class FamEntry {
  FamEntry(
      {required this.famname,
      required this.message,
      required this.fammood,
      required this.members});
  String famname;
  String message;
  String fammood;
  String members;
}

class FootList {
  FootList({
    required this.username,
    required this.foottype,
    required this.message,
  });
  final String username;
  final String foottype;
  final String message;
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  StreamSubscription<QuerySnapshot>? _familyBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;
  StreamSubscription<QuerySnapshot>? _userListSubscription;
  List<UserEntry> _userslist = [];
  List<UserEntry> get userslist => _userslist;

  late List<FamEntry> _famlist = [];
  List<FamEntry> get famlist => _famlist;

  List<FootList> _footlist = [];
  List<FootList> get footlist => _footlist;
  String currentUser = 'default';
  String currentFamily = 'default';
  int currentFamilyIndex = 0;

  // UserEntry?  myuser;
  // FamEntry? myfam;

  String xxx = 'from here ';

  Future<void> init() async {
    currentUser = FirebaseAuth.instance.currentUser!.displayName!;
    //currentFamily = famlist[0].famname;
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform);

    //FirebaseUIAuth.configureProviders([
    //  EmailAuthProvider(),
    // ]);
    // currentUser = FirebaseAuth.instance.currentUser!.displayName!;
    // currentFamily = famlist[0].famname;
    /*
    _userslist.add(UserEntry(
      name: 'terry',
      message: 'soso',
      famname: 'ohana',
    ));
    _userslist.add(UserEntry(
      name: 'goguma',
      message: 'good',
      famname: 'ohana',
    ));
    _userslist.add(UserEntry(
      name: 'gamja',
      message: 'sad',
      famname: 'ohana',
    ));
    _userslist.add(UserEntry(
      name: 'dotory',
      message: 'bad',
      famname: 'ohana',
    ));
    _userslist.add(UserEntry(
      name: 'mandu',
      message: 'good',
      famname: 'aloha',
    ));
    */

    _famlist.add(FamEntry(
        famname: 'ohana', message: '모두들 건강하시고', fammood: 'good', members: ' '));

    _famlist.add(FamEntry(
        famname: 'aloha',
        message: '연락 좀  하고 삽시다',
        fammood: 'bad',
        members: ' '));

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _userListSubscription = FirebaseFirestore.instance
            .collection('userlist')
            .snapshots()
            .listen((snapshot) {
          _userslist = [];
          for (final document in snapshot.docs) {
            _userslist.add(
              UserEntry(
                birthday: document.data()['birthday'] as String,
                email: document.data()['email'] as String,
                phone: document.data()['phone'] as String,
                name: document.data()['name'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _userslist = [];
        _userListSubscription?.cancel();
      }
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _familyBookSubscription = FirebaseFirestore.instance
            .collection('familybook')
            .snapshots()
            .listen((snapshot) {
          _famlist = [];
          for (final document in snapshot.docs) {
            _famlist.add(
              FamEntry(
                famname: document.data()['family'] as String,
                message: document.data()['owner'] as String,
                members: document.data()['member'] as String,
                fammood: document.data()['fammood'] as String,
              ),
            );
          }
          currentFamily = _famlist[0].famname;
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _famlist = [];
        _familyBookSubscription?.cancel();
      }

      notifyListeners();
    });
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  void setFamily(int index) {
    currentFamily = famlist[index].famname;

    notifyListeners();
  }

  void setFamilyIndex(int index) {
    currentFamilyIndex = index;

    notifyListeners();
  }

  void setUser(int index) {
    currentUser = userslist[index].name;

    notifyListeners();
  }

  void setCurrentUser(String iname) {
    currentUser = iname;

    notifyListeners();
  }
}

class GuestBook extends StatefulWidget {
  const GuestBook({
    super.key,
    required this.addMessage,
    required this.messages,
  });
  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages; // new
  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ...to here.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Modify from here...
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
      ],
      // ...to here.
    );
  }
}

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<TalkScreen> createState() => _TalkScreen();
}

class _TalkScreen extends State<TalkScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Card(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('팸톡, 주제별 가족 대화 공간')),
              ),
            ),
          )),
      Card(
        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appState.loggedIn) ...[
                const Header('Discussion'),
                GuestBook(
                  addMessage: (message) =>
                      appState.addMessageToGuestBook(message),
                  messages: appState.guestBookMessages, // new
                ),
              ],
            ],
          ),
        ),
      )
    ]);
  }
}
