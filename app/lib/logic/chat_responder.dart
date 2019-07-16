import 'package:flutter/material.dart';

class ChatResponder extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];

  ChatResponder() {
    initMessage();
  }

  void recieveMessage(String message) async {
    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: message,
        delivered: false,
        isResponse: false,
        time: "${time.hour}:${time.minute}");

    chatMessages.add(chatMessage);
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 1400));
    chatMessage.delivered = true;
    notifyListeners();

    sendMessage(message);
  }

  void sendMessage(String response) async {
    await Future.delayed(Duration(milliseconds: 3000));
    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: "Hollow",
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    chatMessages.add(chatMessage);
    notifyListeners();
  }

  void initMessage() async {
    DateTime time = DateTime.now();
    ChatMessage chatMessage = ChatMessage(
        message:
            'Hi... This is an automated message.\nCan you please enter your team name to validate your entry?',
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    await Future.delayed(Duration(milliseconds: 300));
    chatMessages.add(chatMessage);
    notifyListeners();
  }
}

class ChatMessage {
  ChatMessage({
    this.message,
    this.time,
    this.delivered,
    this.isResponse,
  });

  final String message;
  final String time;
  final bool isResponse;
  bool delivered;
}
