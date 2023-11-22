
import 'package:hive/hive.dart';

import '../../domain/entities/message.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
class MessageModel {
  @HiveField(0)

  final String chatId;
  @HiveField(1)
  final String senderId;
  @HiveField(2)
  final String recipientId;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final DateTime createdAt;

  const MessageModel({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(
    Map<String, dynamic> json,
    String chatId,
  ) {
    return MessageModel(
      chatId: chatId,
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      chatId: message.chatId,
      senderId: message.senderId,
      recipientId: message.recipientId,
      text: message.text,
      createdAt: message.createdAt,
    );
  }

  Message toEntity() {
    return Message(
      chatId: chatId,
      senderId: senderId,
      recipientId: recipientId,
      text: text,
      createdAt: createdAt,
    );
  }
}
