
import 'package:proapp/Widgets/Twilio/messages.dart';

class MyTwilio {
  final String _accountSid;
  final String _authToken;

  const MyTwilio(this._accountSid, this._authToken);

  Messages get messages => Messages(_accountSid, _authToken);
}