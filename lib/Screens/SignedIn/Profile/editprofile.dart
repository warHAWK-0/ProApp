import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Screens/SignedIn/Profile/changePassword.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class EditProfile extends StatefulWidget {
  final UserDetails userDetails;

  const EditProfile({Key key, this.userDetails}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _btnEnabled = false;
  TextEditingController phoneController;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  String titleText = "Edit you profile";
  @override
  Widget build(BuildContext context) {

    // storing userdetails
    String address = widget.userDetails.address;
    String mobileNo = widget.userDetails.mobileNo;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          child: Text(
            titleText,
            style: Heading2(Colors.black, letterSpace: 1.25),          ),
          backIcon: true,
          elevation: true,
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
                        imageProfile(),
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
                        Container(
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            initialValue: widget.userDetails.mobileNo,
                           onChanged: (value){
                             setState(() {
                               mobileNo = value;
                             });

                           },
                            showCursor: true,
                            autovalidate: true,
                            // ignore: missing_return
                            validator: (String txt) {
                              bool isValid = txt == mobileNo;
                              if (isValid == false) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    _btnEnabled = txt != mobileNo;
                                  });
                                });
                              }
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
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
                                enabledBorder: OutlineInputBorder(
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
                        Container(
                          // address
                          height: 81,
                          width: double.infinity,
                          child: TextFormField(
                            initialValue: address,
                            autovalidate: true,
                            // ignore: missing_return
                            validator: (String txt) {
                              bool isValid = txt == address;
                              if (isValid == false) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    _btnEnabled = txt != address;
                                  });
                                });
                              }
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 12, top: 20, bottom: 0),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                  BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                errorBorder: InputBorder
                                    .none, //for error write code change color to red
                                enabledBorder: OutlineInputBorder(
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
                          height: 32.0,
                        ),
                        InkWell(
                          onTap: _btnEnabled ? () => _nav() : null,
                          child: Container(
                            //Sign up button
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              color: _btnEnabled ? primarygreen : Colors.grey[300],
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: loading
                                ? Loading()
                                : Center(
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
  var url;
  Future _getImage() async {
      final ref = FirebaseStorage.instance.ref().child('Profile/profilepic.png');
      url = await ref.getDownloadURL();
    }
    // retrieving image url from firebase storage
     _showProfilePicture(){
      return FutureBuilder(
        future: _getImage(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Loading();
          else{
            return CircleAvatar(
              radius: 32.0,
              backgroundImage: _imageFile == null
              ? NetworkImage(url):
              FileImage(File(_imageFile.path)),
  );
          }
        },
      );
    }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        _showProfilePicture(),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primarygreen,
              ),
              child: Icon(
                EvaIcons.edit,
                color: Colors.black, //to change the picture
                size: 16.0,
              ),
            ),
          ),
        ),
      ]),
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
                onTap: (){
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
                      Text('CAMERA',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
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
                      Text('GALLERY',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),
            ]
          ),
          Spacer(),
        ],
      ),
    );
  }
  void _nav() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Otp2()),);
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
