import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/email_model.dart';
import 'app.dart';

const _avatarsLocation = 'reply/avatars';

const hiveDB = 'nalininoa';
const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

final _inbox = <Email>[
  InboxEmail(
    id: 1,
    sender: 'Google Express',
    time: '15 minutes ago',
    subject: 'Package shipped!',
    message: 'Cucumber Mask Facial has shipped.\n\n'
        'Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don\'t receive your package before the end of next week, please reach out to us for details on your shipment.\n\n'
        'As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!',
    avatar: '$_avatarsLocation/avatar_express.png',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 2,
    sender: 'Ali Connors',
    time: '4 hrs ago',
    subject: 'Brunch this weekend?',
    message:
        'I\'ll be in your neighborhood doing errands and was hoping to catch you for a coffee this Saturday. If you don\'t have anything scheduled, it would be great to see you! It feels like its been forever.\n\n'
        'If we do get a chance to get together, remind me to tell you about Kim. She stopped over at the house to say hey to the kids and told me all about her trip to Mexico.\n\n'
        'Talk to you soon,\n\n'
        'Ali',
    avatar: '$_avatarsLocation/avatar_5.jpg',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 3,
    sender: 'Allison Trabucco',
    time: '5 hrs ago',
    subject: 'Bonjour from Paris',
    message: 'Here are some great shots from my trip...',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: true,
  ),
  InboxEmail(
    id: 4,
    sender: 'Trevor Hansen',
    time: '9 hrs ago',
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
  ),
  InboxEmail(
    id: 5,
    sender: 'Frank Hawkins',
    time: '10 hrs ago',
    subject: 'Update to Your Itinerary',
    message: '',
    avatar: '$_avatarsLocation/avatar_4.jpg',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 6,
    sender: 'Google Express',
    time: '12 hrs ago',
    subject: 'Delivered',
    message: 'Your shoes should be waiting for you at home!',
    avatar: '$_avatarsLocation/avatar_express.png',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 7,
    sender: 'Frank Hawkins',
    time: '4 hrs ago',
    subject: 'Your update on the Google Play Store is live!',
    message:
        'Your update is now live on the Play Store and available for your alpha users to start testing.\n\n'
        'Your alpha testers will be automatically notified. If you\'d rather send them a link directly, go to your Google Play Console and follow the instructions for obtaining an open alpha testing link.',
    avatar: '$_avatarsLocation/avatar_4.jpg',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 8,
    sender: 'Allison Trabucco',
    time: '6 hrs ago',
    subject: 'Try a free TrailGo account',
    message:
        'Looking for the best hiking trails in your area? TrailGo gets you on the path to the outdoors faster than you can pack a sandwich.\n\n'
        'Whether you\'re an experienced hiker or just looking to get outside for the afternoon, there\'s a segment that suits you.',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: false,
  ),
  InboxEmail(
    id: 9,
    sender: 'Allison Trabucco',
    time: '4 hrs ago',
    subject: 'Free money',
    message:
        'You\'ve been selected as a winner in our latest raffle! To claim your prize, click on the link.',
    avatar: '$_avatarsLocation/avatar_3.jpg',
    recipients: 'Jeff',
    containsPictures: false,
    inboxType: InboxType.spam,
  ),
];

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Email>(hiveDB);
  Hive.registerAdapter(InboxTypeAdapter());
  Hive.registerAdapter(InboxEmailAdapter());
  Hive.registerAdapter(MailboxPageTypeAdapter());
  Hive.registerAdapter(EmailAdapter());
  Box<Email> favoriteBooksBox = Hive.box(hiveDB);
  if (favoriteBooksBox.isEmpty) {
    _inbox.forEach((Email email) {
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
