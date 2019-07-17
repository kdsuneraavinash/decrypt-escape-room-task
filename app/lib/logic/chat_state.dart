import 'package:app/logic/chat_responder.dart';

abstract class ChatState {
  sendMessage(ChatResponder responder, String message);

  ChatMessage composeMessage(String message,
      [bool delivered = false, bool isTyping = true, bool isSolution = false]) {
    DateTime time = DateTime.now();
    return ChatMessage(
        message: message,
        delivered: delivered,
        isResponse: true,
        isTyping: isTyping,
        isSolution: isSolution,
        time: "${time.hour}:${time.minute}");
  }

  Future<void> wait(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
