import '../chat_responder.dart';
import '../chat_state.dart';
import '../data.dart';
import 'solution_state.dart';

class TimeValidatorState extends ChatState {
  final String teamName;

  TimeValidatorState(this.teamName);

  @override
  sendMessage(ChatResponder responder, String message) async {
    String response;
    ChatState nextState;

    if (Data.data[teamName].time == message.trim()) {
      response = "Record Matched..\n\n"
          'Your code is sent.';
      nextState = SolutionState(Data.data[teamName].solution);
    } else {
      response = "Record Mismatch... Please re-enter time.";
      nextState = this;
    }

    ChatMessage chatMessage = composeMessage(response);
    responder.addChatMessage(chatMessage);

    await wait(3000);

    chatMessage.finishTyping(responder);
    responder.changeState(nextState);

    if (nextState is SolutionState) {
      nextState.sendMessage(responder, null);
    }
  }
}
