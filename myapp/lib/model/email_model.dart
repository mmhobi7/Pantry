import 'package:hive/hive.dart';

part 'email_model.g.dart';

@HiveType(typeId : 1)
class Email {
  Email({
    this.id,
    this.sender,
    this.time,
    this.subject,
    this.message,
    this.avatar,
    this.recipients,
    this.containsPictures,
    this.type,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String sender;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final String subject;
  @HiveField(4)
  final String message;
  @HiveField(5)
  final String avatar;
  @HiveField(6)
  final String recipients;
  @HiveField(7)
  final bool containsPictures;
  @HiveField(8)
  final List<String> type;
}

@HiveType(typeId : 2)
class InboxEmail extends Email {
  InboxEmail({
    @HiveField(0)
    int id,
    @HiveField(1)
    String sender,
    @HiveField(2)
    String time,
    @HiveField(3)
    String subject,
    @HiveField(4)
    String message,
    @HiveField(5)
    String avatar,
    @HiveField(6)
    String recipients,
    @HiveField(7)
    bool containsPictures,
    @HiveField(8)
    List<String> type,
    this.inboxType = InboxType.normal,
  }) : super(
          id: id,
          sender: sender,
          time: time,
          subject: subject,
          message: message,
          avatar: avatar,
          recipients: recipients,
          containsPictures: containsPictures,
          type: type,
        );

  InboxType inboxType;
}

// The different mailbox pages that the Reply app contains.
@HiveType(typeId : 3)
enum MailboxPageType {
  @HiveField(0)
  inbox,
  @HiveField(1)
  starred,
  @HiveField(2)
  sent,
  @HiveField(3)
  trash,
  @HiveField(4)
  spam,
  @HiveField(5)
  drafts,
}

// Different types of mail that can be sent to the inbox.
@HiveType(typeId : 4)
enum InboxType {
  @HiveField(0)
  normal,
  @HiveField(1)
  spam,
}
