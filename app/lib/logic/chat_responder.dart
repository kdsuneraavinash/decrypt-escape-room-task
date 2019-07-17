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
    if (message.trim() == "") return;

    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: message,
        delivered: false,
        isResponse: false,
        time: "${time.hour}:${time.minute}");

    addChatMessage(chatMessage);

    await Future.delayed(Duration(milliseconds: 800));
    chatMessage.delivered = true;
    updateUI();

    sendMessage(message);
  }

  void sendMessage(String response) async {
    await Future.delayed(Duration(milliseconds: 1000));
    await state.sendMessage(this, response);
    updateUI();
  }

  void addChatMessage(ChatMessage message) {
    chatMessages.add(message);
    updateUI();
  }

  void updateUI() {
    notifyListeners();
  }

  void changeState(ChatState state) {
    this.state = state;
  }
}

class ChatMessage {
  ChatMessage({
    this.message,
    this.time,
    this.delivered,
    this.isResponse,
    this.isSolution = false,
    this.isTyping = true,
  });

  finishTyping(ChatResponder responder) {
    isTyping = false;
    responder.updateUI();
  }

  final String message;
  final String time;
  final bool isResponse;
  bool delivered;
  bool isTyping;
  final bool isSolution;
}
