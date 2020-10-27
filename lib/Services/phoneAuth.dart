import 'package:firebase_auth/firebase_auth.dart';
class PhoneAuth{
  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    //signIn(authCreds);
  }
}