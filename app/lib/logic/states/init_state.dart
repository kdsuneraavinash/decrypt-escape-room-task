import '../chat_responder.dart';
import '../chat_state.dart';

import 'name_validator_state.dart';

class InitState extends ChatState {
  @override
  sendMessage(ChatResponder responder, String message) async {
    ChatMessage chatMessage = composeMessage(
        'Hi... This is an automated message.\n'
        'Can you please enter your team name to validate your entry?',
        true,
        false);

    responder.addChatMessage(chatMessage);
    responder.changeState(NameValidatorState());
  }
}
