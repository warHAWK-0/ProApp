import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:proapp/Screens/SignedIn/Profile/ProfileMain.dart';
import 'package:proapp/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/otp.dart';
import 'package:proapp/Widgets/themes.dart';

class EditProfile extends StatefulWidget {
  final UserDetails userDetails;
  final String uid;
  String userProfileUrl;
  EditProfile({Key key, this.userDetails, this.uid, this.userProfileUrl}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DatabaseService databaseService;
  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  FocusNode f1, f2;
  TextEditingController phoneController;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  String newMobNo,newAddress;

  @override
  void initState() {
    super.initState();
    f1 = FocusNode();
    f2 = FocusNode();
  }

  void submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OTP(
          prevMobNo: widget.userDetails.mobileNo,
          uid: widget.uid,
          newUserDetails: UserDetails(
            email: widget.userDetails.email,
            name: widget.userDetails.name,
            address: newAddress,
            mobileNo: newMobNo,
          ),
        )),
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
            loading = false;
          });
        },
        onFieldSubmitted: (val) => FocusScope.of(context).requestFocus(f1),
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

  Widget showAddressField() {
    return Container(
      //input fields email
      height: 81,
      width: double.infinity,
      child: TextFormField(
        initialValue: widget.userDetails.address,
        onChanged: (value) {
          setState(() {
            newAddress = value;
            loading = false;
          });
        },
        maxLines: 4,
        autofocus: false,
        validator: (value) =>
            value.length <= 0 ? "Enter a valid address" : null,
        onFieldSubmitted: (val) => FocusScope.of(context).requestFocus(f2),
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

  @override
  Widget build(BuildContext context) {
    databaseService = new DatabaseService(uid: widget.uid);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileMain(uid: widget.uid,)));
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
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
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
                          height: 7,
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
                        SizedBox(height: 19),
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
                        showAddressField(),
                        SizedBox(
                          height: 32.0,
                        ),
                        InkWell(
                          onTap: loading ? null : submit,
                          child: Container(
                            //Sign up button
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              color: loading ? Colors.grey[300] : primarygreen,
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
            );
          },
        ));
  }

  // retrieving image url from firebase storage
  _showProfilePicture() {
    return Stack(
      children: [
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
      ]
    );
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
