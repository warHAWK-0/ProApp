import 'address.dart';

class UserDetails{
  String name,
      mobileNo,
      email;
  Map address;
  bool verified;

  UserDetails({
    this.name,
    this.mobileNo,
    this.address,
    this.email,
    this.verified
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "mobileNo" : mobileNo,
    "email": email,
    "address": address,
    "verified" : verified
  };
}