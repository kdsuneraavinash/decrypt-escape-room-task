import '../chat_responder.dart';
import '../chat_state.dart';

class TestState extends ChatState {
  @override
  sendMessage(ChatResponder responder, String message) {
    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: "Hollow",
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    responder.chatMessages.add(chatMessage);
  }
}
