import 'package:talker_flutter/talker_flutter.dart';

class TalkerHandler {
  final Talker _talker;

  TalkerHandler(this._talker);

  sendDebugMessage(message) {
    _talker.debug(message);
  }
}
