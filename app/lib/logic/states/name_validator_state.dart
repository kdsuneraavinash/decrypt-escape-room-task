import '../chat_responder.dart';
import '../chat_state.dart';
import '../data.dart';
import 'time_validator_state.dart';

class NameValidatorState extends ChatState {
  @override
  sendMessage(ChatResponder responder, String message) async {
    DateTime time = DateTime.now();
    bool isValid = false;
    String response =
        "I'm sorry. The team name is not registered.\nPlease re-enter your team name.";

    isValid = (Data.data.containsKey(message.trim()));

    if (isValid) {
      response = "Team found... Registered team name...\n\n"
          'Please enter the time you enetered the building to confirm your identity (Format HH:MM)';
    }

    ChatMessage chatMessage = ChatMessage(
        message: response,
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    responder.chatMessages.add(chatMessage);

    responder.updated();
    await Future.delayed(Duration(seconds: 2));
    chatMessage.finishTyping();
    responder.updated();

    if (isValid) {
      responder.state = TimeValidatorState(message.trim());
    }
  }
}
