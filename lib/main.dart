import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'constants.dart';
import 'model/email_model.dart';

const _avatarsLocation = 'reply/avatars';

final _inbox = <Email>[
  InboxEmail(
    id: 1,
    sender: 'Google Express',
    time: DateTime.now(),
    subject: 'Package shipped!',
    message: 'Cucumber Mask Facial has shipped.\n\n'
        'Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don\'t receive your package before the end of next week, please reach out to us for details on your shipment.\n\n'
        'As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!',
    avatar: '$_avatarsLocation/avatar_express.png',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 20,
  ),
  InboxEmail(
    id: 2,
    sender: 'Ali Connors',
    time: DateTime.now(),
    subject: 'Brunch this weekend?',
    message:
        'I\'ll be in your neighborhood doing errands and was hoping to catch you for a coffee this Saturday. If you don\'t have anything scheduled, it would be great to see you! It feels like its been forever.\n\n'
        'If we do get a chance to get together, remind me to tell you about Kim. She stopped over at the house to say hey to the kids and told me all about her trip to Mexico.\n\n'
        'Talk to you soon,\n\n'
        'Ali',
    avatar: '$_avatarsLocation/avatar_5.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 8.2,
  ),
  InboxEmail(
    id: 3,
    sender: 'Allison Trabucco',
    time: DateTime.now(),
    subject: 'Bonjour from Paris',
    message: 'Here are some great shots from my trip...',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: true,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 1.2,
  ),
  InboxEmail(
    id: 4,
    sender: 'Trevor Hansen',
    time: DateTime.now(),
    subject: 'Brazil trip',
    message:
        'Thought we might be able to go over some details about our upcoming vacation.\n\n'
        'I\'ve been doing a bit of research and have come across a few paces in Northern Brazil that I think we should check out. '
        'One, the north has some of the most predictable wind on the planet. '
        'I\'d love to get out on the ocean and kitesurf for a couple of days if we\'re going to be anywhere near or around Taiba. '
        'I hear it\'s beautiful there and if you\'re up for it, I\'d love to go. Other than that, I haven\'t spent too much time looking into places along our road trip route. '
        'I\'m assuming we can find places to stay and things to do as we drive and find places we think look interesting. But... I know you\'re more of a planner, so if you have ideas or places in mind, lets jot some ideas down!\n\n'
        'Maybe we can jump on the phone later today if you have a second.',
    avatar: '$_avatarsLocation/avatar_8.jpg',
    recipients: 'Allison, Kim, Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 0,
  ),
  InboxEmail(
    id: 5,
    sender: 'Frank Hawkins',
    time: DateTime.now(),
    subject: 'Update to Your Itinerary',
    message: '',
    avatar: '$_avatarsLocation/avatar_4.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 1.98,
  ),
  InboxEmail(
    id: 6,
    sender: 'Google Express',
    time: DateTime.now(),
    subject: 'Delivered',
    message: 'Your shoes should be waiting for you at home!',
    avatar: '$_avatarsLocation/avatar_express.png',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 9.0,
  ),
  InboxEmail(
    id: 7,
    sender: 'Frank Hawkins',
    time: DateTime.now(),
    subject: 'Your update on the Google Play Store is live!',
    message:
        'Your update is now live on the Play Store and available for your alpha users to start testing.\n\n'
        'Your alpha testers will be automatically notified. If you\'d rather send them a link directly, go to your Google Play Console and follow the instructions for obtaining an open alpha testing link.',
    avatar: '$_avatarsLocation/avatar_4.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 5.4,
  ),
  InboxEmail(
    id: 8,
    sender: 'Allison Trabucco',
    time: DateTime.now(),
    subject: 'Try a free TrailGo account',
    message:
        'Looking for the best hiking trails in your area? TrailGo gets you on the path to the outdoors faster than you can pack a sandwich.\n\n'
        'Whether you\'re an experienced hiker or just looking to get outside for the afternoon, there\'s a segment that suits you.',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day+3),
    quantity: 5.0,
  ),
  InboxEmail(
    id: 9,
    sender: 'Allison Trabucco',
    time: DateTime.now(),
    subject: 'Free money',
    message:
        'You\'ve been selected as a winner in our latest raffle! To claim your prize, click on the link.',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["inbox"],
    inboxType: InboxType.spam,
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 2, DateTime.now().day),
    quantity: 5.0,
  ),
];

final _outbox = <Email>[
  InboxEmail(
    id: 10,
    sender: 'Kim Alen',
    time: DateTime.now(),
    subject: 'High school reunion?',
    message:
        'Hi friends,\n\nI was at the grocery store on Sunday night.. when I ran into Genie Williams! I almost didn\'t recognize her afer 20 years!\n\n'
        'Anyway, it turns out she is on the organizing committee for the high school reunion this fall. I don\'t know if you were planning on going or not, but she could definitely use our help in trying to track down lots of missing alums. '
        'If you can make it, we\'re doing a little phone-tree party at her place next Saturday, hoping that if we can find one person, thee more will...',
    avatar: '$_avatarsLocation/avatar_7.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["outbox"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 5.0,
  ),
  InboxEmail(
    id: 11,
    sender: 'Sandra Adams',
    time: DateTime.now(),
    subject: 'Recipe to try',
    message:
        'Raspberry Pie: We should make this pie recipe tonight! The filling is '
        'very quick to put together.',
    avatar: '$_avatarsLocation/avatar_2.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["outbox", "inbox", "drafts"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 5.0,
  ),
];

final _drafts = <Email>[
  InboxEmail(
    id: 12,
    sender: 'Sandra Adams',
    time: DateTime.now(),
    subject: '(No subject)',
    message: 'Hey,\n\n'
        'Wanted to email and see what you thought of',
    avatar: '$_avatarsLocation/avatar_2.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    type: ["drafts"],
    expiry: DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
    quantity: 5.0,
  ),
];

Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();
  print(appDir);
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

void main() async {
  await _deleteAppDir();
  // await _deleteCacheDir();
  await Hive.initFlutter();
  Hive.registerAdapter(InboxTypeAdapter());
  Hive.registerAdapter(InboxEmailAdapter());
  Hive.registerAdapter(MailboxPageTypeAdapter());
  Hive.registerAdapter(EmailAdapter());
  await Hive.openBox<Email>(hiveDB);
  Box<Email> favoriteBooksBox = Hive.box(hiveDB);
  if (favoriteBooksBox.isEmpty) {
    _inbox.forEach((Email email) {
      favoriteBooksBox.put(email.id, email);
    });
    _outbox.forEach((Email email) {
      favoriteBooksBox.put(email.id, email);
    });
    _drafts.forEach((Email email) {
      favoriteBooksBox.put(email.id, email);
    });
  }
  runApp(ReplyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Box<Email> favoriteBooksBox;

  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    // favoriteBooksBox.put(index, books[index]);
  }

  @override
  void initState() {
    super.initState();
    favoriteBooksBox = Hive.box(hiveDB);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getIcon(int listIndex) {
    if (favoriteBooksBox.containsKey(listIndex)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}
