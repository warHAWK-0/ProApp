class UserDetails{
  String name,
      uid,
      mobileNo,
      email,
  address;

  UserDetails({
    this.name,

    this.mobileNo,
    this.address,

    this.uid,

    this.email
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "mobileNo" : mobileNo,
    "email": email,
    "address":address,
  };
}