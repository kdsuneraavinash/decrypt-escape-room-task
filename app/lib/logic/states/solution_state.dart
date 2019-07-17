import '../chat_responder.dart';
import '../chat_state.dart';

class SolutionState extends ChatState {
  final String imageUrl;
  bool isSolutionSentOnce = false;

  SolutionState(this.imageUrl);

  @override
  sendMessage(ChatResponder responder, String message) async {
    if (!isSolutionSentOnce) {
      ChatMessage chatMessage = composeMessage(imageUrl, false, true, true);
      responder.addChatMessage(chatMessage);
      isSolutionSentOnce = true;
      await wait(1000);
      chatMessage.finishTyping(responder);
    }
  }
}
