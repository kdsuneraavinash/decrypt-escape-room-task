import 'package:app/logic/chat_responder.dart';
import 'package:app/logic/chat_state.dart';

import 'test_state.dart';

class InitState extends ChatState {
  @override
  sendMessage(ChatResponder responder) {
    DateTime time = DateTime.now();
    ChatMessage chatMessage = ChatMessage(
        message:
            'Hi... This is an automated message.\nCan you please enter your team name to validate your entry?',
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");
    responder.chatMessages.add(chatMessage);

    responder.state = TestState();
  }
}
