import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'email_model.dart';

const _avatarsLocation = 'reply/avatars';
const hiveDB = 'nalininoa';

class EmailStore with ChangeNotifier {

  Box<Email> userBox = Hive.box(hiveDB);
  Iterable<Email> _inbox;

  static final _outbox = <Email>[
    Email(
      id: 10,
      sender: 'Kim Alen',
      time: '4 hrs ago',
      subject: 'High school reunion?',
      message:
          'Hi friends,\n\nI was at the grocery store on Sunday night.. when I ran into Genie Williams! I almost didn\'t recognize her afer 20 years!\n\n'
          'Anyway, it turns out she is on the organizing committee for the high school reunion this fall. I don\'t know if you were planning on going or not, but she could definitely use our help in trying to track down lots of missing alums. '
          'If you can make it, we\'re doing a little phone-tree party at her place next Saturday, hoping that if we can find one person, thee more will...',
      avatar: '$_avatarsLocation/avatar_7.jpg',
      recipients: 'Jeff',
      containsPictures: false,
    ),
    Email(
      id: 12,
      sender: 'Sandra Adams',
      time: '7 hrs ago',
      subject: 'Recipe to try',
      message:
          'Raspberry Pie: We should make this pie recipe tonight! The filling is '
          'very quick to put together.',
      avatar: '$_avatarsLocation/avatar_2.jpg',
      recipients: 'Jeff',
      containsPictures: false,
    ),
  ];

  static final _drafts = <Email>[
    Email(
      id: 12,
      sender: 'Sandra Adams',
      time: '2 hrs ago',
      subject: '(No subject)',
      message: 'Hey,\n\n'
          'Wanted to email and see what you thought of',
      avatar: '$_avatarsLocation/avatar_2.jpg',
      recipients: 'Jeff',
      containsPictures: false,
    ),
  ];

  List<Email> get _allEmails {
    _inbox=userBox.values.where((email) => email.id.isFinite);
    return [
        ..._inbox,
        ..._outbox,
        ..._drafts,
      ];
  }

  List<Email> get inboxEmails {
    _inbox=userBox.values.where((email) => email.id.isFinite);
    return _inbox.where((email) {
      if (email is InboxEmail) {
        return email.inboxType == InboxType.normal &&
            !trashEmailIds.contains(email.id);
      }
      return false;
    }).toList();
  }

  List<Email> get spamEmails {
    return _inbox.where((email) {
      if (email is InboxEmail) {
        return email.inboxType == InboxType.spam &&
            !trashEmailIds.contains(email.id);
      }
      return false;
    }).toList();
  }

  Email get currentEmail =>
      _allEmails.firstWhere((email) => email.id == _selectedEmailId);

  List<Email> get outboxEmails =>
      _outbox.where((email) => !trashEmailIds.contains(email.id)).toList();

  List<Email> get draftEmails =>
      _drafts.where((email) => !trashEmailIds.contains(email.id)).toList();

  Set<int> starredEmailIds = {};
  bool isEmailStarred(int id) =>
      _allEmails.any((email) => email.id == id && starredEmailIds.contains(id));
  bool get isCurrentEmailStarred => starredEmailIds.contains(currentEmail.id);

  List<Email> get starredEmails {
    return _allEmails
        .where((email) => starredEmailIds.contains(email.id))
        .toList();
  }

  void starEmail(int id) {
    starredEmailIds.add(id);
    notifyListeners();
  }

  void unstarEmail(int id) {
    starredEmailIds.remove(id);
    notifyListeners();
  }

  Set<int> trashEmailIds = {7, 8};
  List<Email> get trashEmails {
    return _allEmails
        .where((email) => trashEmailIds.contains(email.id))
        .toList();
  }

  void deleteEmail(int id) {
    trashEmailIds.add(id);
    notifyListeners();
  }

  int _selectedEmailId = -1;
  int get selectedEmailId => _selectedEmailId;
  set selectedEmailId(int value) {
    _selectedEmailId = value;
    notifyListeners();
  }

  bool get onMailView => _selectedEmailId > -1;

  MailboxPageType _selectedMailboxPage = MailboxPageType.inbox;
  MailboxPageType get selectedMailboxPage => _selectedMailboxPage;
  set selectedMailboxPage(MailboxPageType mailboxPage) {
    _selectedMailboxPage = mailboxPage;
    notifyListeners();
  }

  bool _onSearchPage = false;
  bool get onSearchPage => _onSearchPage;
  set onSearchPage(bool value) {
    _onSearchPage = value;
    notifyListeners();
  }
}
