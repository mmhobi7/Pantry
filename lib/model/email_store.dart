import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import 'email_model.dart';

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
    if (_selectedFolder != "") {
      _inbox = _inbox.where((email) => email.sender.contains(_selectedFolder));
    }
    return _inbox.where((email) => !email.type.contains("trash")).toList();
  }

  List<Email> get spamEmails {
    _inbox = userBox.values.where((email) => email.type.contains("inbox"));
    return _inbox.where((email) {
      if (email is InboxEmail) {
        return email.inboxType == InboxType.spam &&
            !email.type.contains("trash");
      }
      return false;
    }).toList();
  }

  Email get currentEmail =>
      _allEmails.firstWhere((email) => email.id == _selectedEmailId);

  List<Email> get outboxEmails {
    _outbox = userBox.values.where((email) => email.type.contains("outbox"));
    if (_selectedFolder != "") {
      _outbox =
          _outbox.where((email) => email.sender.contains(_selectedFolder));
    }
    return _outbox.where((email) => !email.type.contains("trash")).toList();
  }

  List<Email> get draftEmails {
    _drafts = userBox.values.where((email) => email.type.contains("drafts"));
    if (_selectedFolder != "") {
      _drafts =
          _drafts.where((email) => email.sender.contains(_selectedFolder));
    }
    return _drafts.where((email) => !email.type.contains("trash")).toList();
  }

  bool isEmailStarred(int id) {
    return _allEmails
        .any((email) => email.id == id && email.type.contains("star"));
  }

  bool get isCurrentEmailStarred => currentEmail.type.contains("star");

  List<Email> get starredEmails {
    return _allEmails
        .where((email) =>
            email.type.contains("star") && !email.type.contains("trash"))
        .toList();
  }

  void starEmail(int id) {
    _allEmails.firstWhere((email) => email.id == id).type.add("star");
    notifyListeners();
  }

  void unstarEmail(int id) {
    _allEmails.firstWhere((email) => email.id == id).type.remove("star");
    notifyListeners();
  }

  List<Email> get trashEmails {
    return _allEmails.where((email) => email.type.contains("trash")).toList();
  }

  void deleteEmail(int id) {
    _allEmails.firstWhere((email) => email.id == id).type.add("trash");
    notifyListeners();
  }

  void addItem(InboxEmail item) {
    userBox.add(item);
  }

  int _selectedEmailId = -1;

  int get selectedEmailId => _selectedEmailId;

  set selectedEmailId(int value) {
    _selectedEmailId = value;
    notifyListeners();
  }

  String _selectedFolder = "";

  String get selectedFolder => _selectedFolder;

  set selectedFolder(String value) {
    _selectedFolder = value;
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
    userBox.values.forEach((email) {
      //TODO: optimize
      if (!locations.contains(email.sender)) {
        locations.add(email.sender);
      }
    });
    return locations;
  }
}
