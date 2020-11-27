import 'dart:io' show Platform;

import 'package:proapp/Widgets/Twilio/MyTwilio.dart';
import 'package:proapp/Widgets/themes.dart';


Future<void> sendSMS(String toPhoneNumber, String messageBody) async {
  var _accountSid = Platform.environment['TWILIO_ACCOUNT_SID'];
  var _authToken = Platform.environment['TWILIO_AUTH_TOKEN'];

  _accountSid ??= twilioSID;
  _authToken ??= twilioAuthToken;

  // Create an authenticated client instance for Twilio API
  var client = new MyTwilio(_accountSid, _authToken);

  // Send a text message
  Map message = await client.messages.create({
    'body': messageBody,
    'from': twilioMyPhoneNumber,
    'to': '+91$toPhoneNumber',
  });
  // TODO: check message body and show toast message
  print(message);
}