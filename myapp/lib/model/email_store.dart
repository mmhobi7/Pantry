import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'email_model.dart';

const _avatarsLocation = 'reply/avatars';
const hiveDB = 'bruhb';

class EmailStore with ChangeNotifier {

  Box<Email> userBox = Hive.box(hiveDB);
  Iterable<Email> _inbox;
  Iterable<Email> _outbox;
  Iterable<Email> _drafts;


  List<Email> get _allEmails {
    _inbox = userBox.values.where((email) => email.type.contains("inbox"));
    _outbox = userBox.values.where((email) => email.type.contains("outbox"));
    _drafts = userBox.values.where((email) => email.type.contains("drafts"));
    return [
      ..._inbox,
      ..._outbox,
      ..._drafts,
    ];
  }

  List<Email> get inboxEmails {
    _inbox = userBox.values.where((email) => email.type.contains("inbox"));
    return _inbox.where((email) {
      if (email is InboxEmail) {
        return email.inboxType == InboxType.normal;
      }
      return false;
    }).toList();
  }

  List<Email> get spamEmails {
    _inbox = userBox.values.where((email) => email.type.contains("inbox"));
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

  List<Email> get outboxEmails {
    _outbox = userBox.values.where((email) => email.type.contains("outbox"));
    return _outbox.where((email) => !trashEmailIds.contains(email.id)).toList();
  }

  List<Email> get draftEmails {
    _drafts = userBox.values.where((email) => email.type.contains("drafts"));
    return _drafts.where((email) => !trashEmailIds.contains(email.id)).toList();
  }

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
    // trashEmailIds.add(id);
    userBox.delete(id);
    notifyListeners();
  }

  void addItem(InboxEmail item) {
    // var last = userBox.values.where((email) => email.type.contains("outbox")).;
    print("niggg");
    print(item.subject);
    userBox.add(item);
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

  List<String> getLocs() {
    List<String> locations = [];
    userBox.values.forEach((email) { //TODO: optimize
      if (!locations.contains(email.sender)) {
        locations.add(email.sender);
      }
    });
    print(locations);
    return locations;
  }
}
