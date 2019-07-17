import '../chat_responder.dart';
import '../chat_state.dart';
import '../data.dart';
import 'time_validator_state.dart';

class NameValidatorState extends ChatState {
  @override
  sendMessage(ChatResponder responder, String message) async {
    String response;
    ChatState nextState;

    message = message.toUpperCase();

    if (Data.data.containsKey(message.trim())) {
      response = "Team found... Registered E group...\n\n"
          'Please enter the correct time. (Format HH:MM)';
      nextState = TimeValidatorState(message.trim());
    } else {
      response =
          "I'm sorry. The E group is not registered.\nPlease re-enter your E group.";
      nextState = this;
    }

    ChatMessage chatMessage = composeMessage(response);
    responder.addChatMessage(chatMessage);

    await wait(2000);

    chatMessage.finishTyping(responder);
    responder.changeState(nextState);
  }
}
