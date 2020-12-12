import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:proapp/Models/address.dart';
import 'package:proapp/Screens/SignedIn/Profile/ProfileMain.dart';
import 'package:proapp/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Widgets/otp.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditProfile extends StatefulWidget {
  final UserDetails userDetails;
  final String uid;
  String userProfileUrl;
  EditProfile({Key key, this.userDetails, this.uid, this.userProfileUrl})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DatabaseService databaseService;
  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  FocusNode f1, f2;
  Map<String, String> selectedValueMap = Map();
  TextEditingController phoneController;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  String newMobNo, addressLine1;

  final List<String> _states = [
    'A',
    'B',
    'C',
  ];
  final List<String> _city = [
    'A',
    'B',
    'C',
  ];
  final List<String> _pincode = [
    'A',
    'B',
    'C',
  ];

  @override
  void initState() {
    super.initState();
    f1 = FocusNode();
    f2 = FocusNode();
    selectedValueMap["state"] = widget.userDetails.address.state;
    selectedValueMap["city"] = widget.userDetails.address.city;
    selectedValueMap["pincode"] = widget.userDetails.address.pincode;
  }

  submit(Address oldAddress, String oldMobileNo) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Address newAddress = Address(
        addressline1: addressLine1,
        state: selectedValueMap["state"],
        city: selectedValueMap["city"],
        pincode: selectedValueMap["pincode"]
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTP(
                  prevMobNo: widget.userDetails.mobileNo,
                  uid: widget.uid,
                  newUserDetails: UserDetails(
                    email: widget.userDetails.email,
                    name: widget.userDetails.name,
                    address: newAddress == null ? oldAddress : newAddress,
                    mobileNo: newMobNo == null ? oldMobileNo : newMobNo,
                    verified: true,
                  ),
                ),
        ),
      );
    }
    else{
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 120,
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(45, 55, 72, 0.9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Please fill the fields correctly.',
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      );
    }
  }

  Widget showphoneField() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        initialValue: widget.userDetails.mobileNo,
        onChanged: (value) {
          setState(() {
            newMobNo = value;
          });
        },
        keyboardType: TextInputType.number,
        validator: (val) =>
            val.length != 10 ? "Enter a valid phone number" : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: primarygreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.red),
          ), //for error write code change color to red
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
        ),
      ),
    );
  }

  Widget showAddressField(String address_initial) {
    return Container(
      //input fields email
      height: 80,
      width: double.infinity,
      child: TextFormField(
        initialValue: address_initial,
        onChanged: (value) {
          setState(() {
            addressLine1 = value;
          });
        },
        maxLines: 1,
        autofocus: false,
        validator: (val) =>
        val.length == 0 ? "Enter a address" : null,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: primarygreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.red),
          ), //for error write code change color to red
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
        ),
      ),
    );
  }

  Widget getSearchableDropdown(List<String> listData, mapKey) {
    List<DropdownMenuItem> items = [];
    String hint = mapKey;
    for (int i = 0; i < listData.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(
          listData[i],
        ),
        value: listData[i],
      ));
    }
    return SearchableDropdown(
      underline: Container(),
      items: items,
      value: selectedValueMap[mapKey],
      isExpanded: true,
      isCaseSensitiveSearch: false,
      closeButton: 'Close',
      hint: Text(
        hint,
      ),
      onChanged: (value) {
        setState(() {
          selectedValueMap[mapKey] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Address addressVal = widget.userDetails.address;
    String selectedCity = addressVal.city;
    String selectedState = addressVal.state;
    String selectedPinCode = addressVal.pincode;
    String selectedaddressLine1 = addressVal.addressline1;
    List<String> city;
    databaseService = new DatabaseService(uid: widget.uid);
    return StreamBuilder(
      stream: Firestore.instance.collection("Utils").document("CityName").snapshots(),
      builder: (context,snapshot) {
       if(snapshot.hasData) {
             city = snapshot.data["CityName"].cast<String>();
      }
      else {
        //loading screen
      }
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
            title: Center(
              child: Text(
                'Edit your profile       ',
                style: Heading2(Colors.black, letterSpace: 1.15),
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 32),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _showProfilePicture(),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.userDetails.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          fontSize: 24,
                          letterSpacing: 0.18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.userDetails.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing: 0.18,
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 12,
                        child: Text(
                          "EMAIL",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          enabled: false,
                          initialValue: widget.userDetails.email,
                          decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 12.0),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ), // myIcon is a 48px-wide widget.
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 12, top: 0, bottom: 0),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide:
                                BorderSide(color: Color(0xffCBD5E0)),
                              ),
                              errorBorder: InputBorder
                                  .none, //for error write code change color to red
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide:
                                BorderSide(color: Color(0xffCBD5E0)),
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 0, 0, 0.45))),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 12,
                        child: Text(
                          "PHONE NUMBER",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      showphoneField(),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 12,
                        child: Text(
                          "ADDRESS",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      showAddressField(selectedaddressLine1),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[350],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: getSearchableDropdown(_states, selectedState),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[350],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: getSearchableDropdown(city, selectedCity),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[350],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: getSearchableDropdown(_pincode, selectedPinCode),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      InkWell(
                        onTap: (){
                          submit(widget.userDetails.address,
                              widget.userDetails.mobileNo);
                        },
                        child: Container(
                          //Sign up button
                          width: double.infinity,
                          height: 46,
                          decoration: BoxDecoration(
                            color: primarygreen,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Intern',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
      );
      }
    );
  }

  // retrieving image url from firebase storage
  _showProfilePicture() {
    return Stack(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(widget.userProfileUrl),
        maxRadius: 50,
      ),
      Positioned(
        bottom: 3.0,
        right: 3.0,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primarygreen,
            ),
            child: Icon(
              EvaIcons.edit,
              color: Colors.black, //to change the picture
              size: 20.0,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Spacer(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primarygreen),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          'CAMERA',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primarygreen),
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          'GALLERY',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
          Spacer(),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    FirebaseStorage storage = FirebaseStorage.instance;
    File image;

    // compress image function
    final filePath = _imageFile.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    var compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 600,
      minHeight: 600,
      quality: 50,
    );

    setState(() {
      widget.userProfileUrl = compressedImage.path;
    });
    print(compressedImage.path);
    image = File(compressedImage.path);
    StorageReference reference =
        storage.ref().child("Profile/${widget.uid}.jpg");
    reference.putFile(image);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
