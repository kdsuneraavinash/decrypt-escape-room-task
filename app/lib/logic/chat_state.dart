import 'package:app/logic/chat_responder.dart';

abstract class ChatState {
  sendMessage(ChatResponder responder, String message);
}
