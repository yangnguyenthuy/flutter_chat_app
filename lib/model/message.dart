import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ChatMessageType { text, audio, image, video }
// ignore: constant_identifier_names
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });

  static List<ChatMessage> allFromResponse(String response, String id) {
    var decodedJson = json.decode(response);

    return decodedJson
        .map((obj) => ChatMessage.fromMap(obj,id))
        .toList()
        .cast<ChatMessage>();
  }

  static ChatMessage fromMap(Map map, String uid) {
    var type, status, isSender;
    if(map['mes_type'] == "Text")
    {
      type = ChatMessageType.text;
    }
    else if(map['mes_type'] == "Img")
    {
      type = ChatMessageType.image;
    }

    if(map['mes_status'] == "not view")
    {
      status = MessageStatus.not_view;
    }
    else if(map['mes_status'] == "view")
    {
      status = MessageStatus.viewed;
    }

    if(int.parse(map['acc_id']) == int.parse(uid))
    {
      isSender = true;
    }
    else
    {
      isSender = false;
    }

    return ChatMessage(
      text: map['content'],
      messageType: type,
      messageStatus: status,
      isSender: isSender,
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json, String uid) {
    var type, status, isSender;
    if(json['mes_type'] == "Text")
    {
      type = ChatMessageType.text;
    }

    if(json['mes_status'] == "not view")
    {
      status = MessageStatus.not_view;
    }

    if(int.parse(json['acc_id']) == int.parse(uid))
    {
      isSender = true;
    }
    else
    {
      isSender = false;
    }

    var mes = ChatMessage(
      text: json['content'],
      messageType: type,
      messageStatus: status,
      isSender: isSender,
    );
    return mes;
  }
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "Error happend",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  ChatMessage(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
];