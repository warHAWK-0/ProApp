class Address{
  final String addressline1;
  final String state;
  final String city;
  final String pincode;

  Address({this.addressline1, this.state, this.city, this.pincode});

  Map<String, dynamic> toJson() => {
    'AddressLine1' : addressline1,
    'State' : state,
    'City' : city,
    'Pincode' : pincode
  };

  Address getMap(Map<dynamic, dynamic> map) => Address(
    addressline1: map["AddressLine1"].toString(),
    state: map["State"].toString(),
    city: map["City"].toString(),
    pincode: map["Pincode"].toString(),
  );
}