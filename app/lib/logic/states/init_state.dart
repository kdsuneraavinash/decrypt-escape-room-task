import '../chat_responder.dart';
import '../chat_state.dart';

import 'name_validator_state.dart';

class InitState extends ChatState {
  @override
  sendMessage(ChatResponder responder, String message) async {
    DateTime time = DateTime.now();
    ChatMessage chatMessage = ChatMessage(
        message:
            'Hi... This is an automated message.\nCan you please enter your team name to validate your entry?',
        delivered: true,
        isResponse: true,
        isTyping: false,
        time: "${time.hour}:${time.minute}");
    responder.chatMessages.add(chatMessage);
    responder.updated();

    responder.state = NameValidatorState();
  }
}
