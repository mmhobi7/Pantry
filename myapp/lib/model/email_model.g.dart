// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailboxPageTypeAdapter extends TypeAdapter<MailboxPageType> {
  @override
  final int typeId = 3;

  @override
  MailboxPageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MailboxPageType.inbox;
      case 1:
        return MailboxPageType.starred;
      case 2:
        return MailboxPageType.sent;
      case 3:
        return MailboxPageType.trash;
      case 4:
        return MailboxPageType.spam;
      case 5:
        return MailboxPageType.drafts;
      default:
        return MailboxPageType.inbox;
    }
  }

  @override
  void write(BinaryWriter writer, MailboxPageType obj) {
    switch (obj) {
      case MailboxPageType.inbox:
        writer.writeByte(0);
        break;
      case MailboxPageType.starred:
        writer.writeByte(1);
        break;
      case MailboxPageType.sent:
        writer.writeByte(2);
        break;
      case MailboxPageType.trash:
        writer.writeByte(3);
        break;
      case MailboxPageType.spam:
        writer.writeByte(4);
        break;
      case MailboxPageType.drafts:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailboxPageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InboxTypeAdapter extends TypeAdapter<InboxType> {
  @override
  final int typeId = 4;

  @override
  InboxType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return InboxType.normal;
      case 1:
        return InboxType.spam;
      default:
        return InboxType.normal;
    }
  }

  @override
  void write(BinaryWriter writer, InboxType obj) {
    switch (obj) {
      case InboxType.normal:
        writer.writeByte(0);
        break;
      case InboxType.spam:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InboxTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmailAdapter extends TypeAdapter<Email> {
  @override
  final int typeId = 1;

  @override
  Email read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Email(
      id: fields[0] as int,
      sender: fields[1] as String,
      time: fields[2] as String,
      subject: fields[3] as String,
      message: fields[4] as String,
      avatar: fields[5] as String,
      recipients: fields[6] as String,
      containsPictures: fields[7] as bool,
      type: (fields[8] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Email obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.recipients)
      ..writeByte(7)
      ..write(obj.containsPictures)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InboxEmailAdapter extends TypeAdapter<InboxEmail> {
  @override
  final int typeId = 2;

  @override
  InboxEmail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InboxEmail(
      id: fields[0] as int,
      sender: fields[1] as String,
      time: fields[2] as String,
      subject: fields[3] as String,
      message: fields[4] as String,
      avatar: fields[5] as String,
      recipients: fields[6] as String,
      containsPictures: fields[7] as bool,
      type: (fields[8] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, InboxEmail obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.recipients)
      ..writeByte(7)
      ..write(obj.containsPictures)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InboxEmailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
