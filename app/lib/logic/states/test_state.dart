import 'package:app/logic/chat_responder.dart';
import 'package:app/logic/chat_state.dart';

class TestState extends ChatState {
  @override
  sendMessage(ChatResponder responder) {
    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: "Hollow",
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    responder.chatMessages.add(chatMessage);
  }
}
