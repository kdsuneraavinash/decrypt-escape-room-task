import '../chat_responder.dart';
import '../chat_state.dart';
import '../data.dart';
import 'test_state.dart';

class TimeValidatorState extends ChatState {
  final String teamName;

  TimeValidatorState(this.teamName);

  @override
  sendMessage(ChatResponder responder, String message) {
    DateTime time = DateTime.now();
    bool isValid = false;
    String response = "Record Mismatch... Please re-enter time.";

    isValid = Data.data[teamName].time == message.trim();

    if (isValid) {
      response = "Record Matched..\n\n"
          'Your code is sent.';
    }

    ChatMessage chatMessage = ChatMessage(
        message: response,
        delivered: true,
        isResponse: true,
        time: "${time.hour}:${time.minute}");

    responder.chatMessages.add(chatMessage);

    if (isValid) {
      responder.state = TestState();
    }
  }
}
