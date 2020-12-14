import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class ConfirmLocation extends StatefulWidget {
  final String uid;
  final File imageFile;
  final Map<String, String> selectedValueMap;
  final String description;

  const ConfirmLocation(
      {Key key, this.imageFile, this.selectedValueMap, this.description, this.uid})
      : super(key: key);
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  DatabaseService db;
  String _location;
  Auth _auth = AuthService();
  bool _loading = false;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress, pincode;
  @override
  void initState() {
    locationController = TextEditingController();
    super.initState();
  }

  Future _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        pincode = place.postalCode;
        _currentAddress = "   ${place.name} " +
            ", " +
            "${place.locality}" +
            ", " +
            " ${place.subLocality}" +
            ", " +
            "${place.administrativeArea} " +
            ", " +
            "${place.subAdministrativeArea} " +
            ", " +
            " ${place.thoroughfare} " +
            ", " +
            " ${place.country} " +
            ", " +
            "${place.postalCode}";
      });
    } catch (e) {
      print(e);
    }
  }

  String _buttontext = "GET LOCATION";
  int _buttonflag = 1;
  TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    db = DatabaseService(uid: widget.uid);
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Confirm Location',
          style: Heading2(Colors.black, letterSpace: 1.0),
        ),
        elevation: true,
        backIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "If your location is incorrect, enter the location of the complaint.",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              _currentPosition == null ? Container() : Text(
                _currentAddress,
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromRGBO(0, 0, 0, 0.45))),
                  hintStyle: Heading3(
                    Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                  border: InputBorder.none,
                  hintText: 'Location',
                ),
                onChanged: (text) {
                  setState(() {
                    _location = text;
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: (){
                  _getCurrentLocation();
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primarygreen,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      _buttontext,
                      style: Heading4(Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              InkWell(
                onTap: () async{
                  bool serviceStatus = await Geolocator().isLocationServiceEnabled();
                  if(serviceStatus){
                    // gps is on

                  }
                  else{
                    // gps is off
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
                            height: 150,
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
                                  'Please turn on your GPS from Settings.',
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
                                SizedBox(
                                  width: double.maxFinite,
                                  child: RaisedButton(
                                    elevation: 0.2,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Dismiss"),
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
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primarygreen,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      _buttontext,
                      style: Heading4(Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createButton() {
    return _buttonflag == 1
        ? InkWell(
            onTap: () {
              _getCurrentLocation();
              setState(() {
                _buttonflag = 0;
                _buttontext = "CREATE";
              });
            },
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primarygreen,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  _buttontext,
                  style: Heading4(Colors.white),
                ),
              ),
            ),
          )
        : createComplaintButton();
  }

  Widget createComplaintButton() {
    return _loading
        ? Loading()
        : InkWell(
            splashColor: Colors.transparent,
            onTap: () async {
              //disable the button and show loading animation
              setState(() {
                _loading = true;
              });

              if (true) {
                String uid = await _auth.getCurrentUID();
                String loc;
                if (locationController.text.isEmpty) {
                  loc = _currentAddress;
                } else {
                  loc = locationController.text;
                }

                Random random = new Random();
                String cid = random.nextInt(99999999).toString();
                Complaint _complaint = new Complaint(
                  complaintId: cid,
                  departmentName: widget.selectedValueMap['department'],
                  complaintType: widget.selectedValueMap['complaint'],
                  description: widget.description,
                  status: 'RAISED',
                  uid: uid.toString(),
                  location: loc,
                  start: DateTime.now().toString().substring(0, 16),
                  end: null,
                  verification: null,
                  assigned: null,
                  upvote: 1,
                  likedByUsers: [uid],
                );

                //creating document for new complaint in DATABASE
                await db.myComplaint()
                    .document(cid.toString())
                    .setData(_complaint.toJson());

                // creating a document in all complaints
                await db.allComplaint(pincode).document(cid.toString()).setData(_complaint.toJson());

                //adding image to STORAGE
                db.uploadImageToFirebase(context, widget.imageFile, cid.toString());
                Navigator.pop(context);
                Navigator.pop(context);
              }

              setState(() {
                _loading = false;
              });
            },
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primarygreen,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  _buttontext,
                  style: Heading4(Colors.white),
                ),
              ),
            ),
          );
  }
}

// name locality sub-locality  administrative-area sub-admin-area through-fare country postalcode
