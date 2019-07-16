import 'package:app/logic/states/init_state.dart';
import 'package:flutter/material.dart';

import 'chat_state.dart';

class ChatResponder extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];
  ChatState state;

  ChatResponder() {
    state = InitState();
    sendMessage("");
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

    await Future.delayed(Duration(milliseconds: 800));
    chatMessage.delivered = true;
    notifyListeners();

    sendMessage(message);
  }

  void sendMessage(String response) async {
    await Future.delayed(Duration(milliseconds: 1000));
    state.sendMessage(this, response);
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
