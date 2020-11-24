class UserDetails{
  String name,
      mobileNo,
      email,
  address;

  UserDetails({
    this.name,
    this.mobileNo,
    this.address,
    this.email
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "mobileNo" : mobileNo,
    "email": email,
    "address":address,
  };
}