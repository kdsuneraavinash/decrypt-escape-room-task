import '../chat_responder.dart';
import '../chat_state.dart';

class SolutionState extends ChatState {
  final String imageUrl;
  bool isSolutionSentOnce = false;

  SolutionState(this.imageUrl);

  @override
  sendMessage(ChatResponder responder, String message) async {
    DateTime time = DateTime.now();

    ChatMessage chatMessage = ChatMessage(
        message: imageUrl,
        delivered: true,
        isResponse: true,
        isSolution: true,
        time: "${time.hour}:${time.minute}");

    if (!isSolutionSentOnce) {
      responder.chatMessages.add(chatMessage);
      isSolutionSentOnce = true;
    }

    responder.updated();
    await Future.delayed(Duration(seconds: 1));
    chatMessage.finishTyping();
    responder.updated();
  }
}