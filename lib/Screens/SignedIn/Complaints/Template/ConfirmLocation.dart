import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/ToastMessage.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';




class ConfirmLocation extends StatefulWidget {
  final File imageFile;
  final Map<String, String> selectedValueMap;
  final String description;


  const ConfirmLocation({Key key, this.imageFile,this.selectedValueMap,this.description}) : super(key: key);
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  DatabaseService _initiateDBService() => new DatabaseService();
  String _location;
  Auth _auth = AuthService();
  bool _loading = false;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String region;
  Position _currentPosition;
  String _currentAddress;
  @override
  void initState(){
  locationController=TextEditingController();

    super.initState();
  }

  _getCurrentLocation() {
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
        _currentAddress =
        "   ${place.name} "+", "+"${place.locality}"+", "+" ${place.subLocality}"+", "+"${place.administrativeArea} "+", "+"${place.subAdministrativeArea} "+", "+" ${place.thoroughfare} "+", "+" ${place.country} "+", "+"${place.postalCode}";
      region=place.administrativeArea;
      });

    } catch (e) {
      print(e);
    }
  }

  String _buttontext="GET LOCATION";
int _buttonflag=1;
TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    DatabaseService db = _initiateDBService();

    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Confirm Location',
          style: Heading2(Colors.black,letterSpace: 1.0),
        ),
        elevation: true,
        backIcon: true,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            Text( "If your current location is incorrect, enter your location",style: GoogleFonts.inter(
              textStyle:TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),),
            SizedBox(height: 16,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _currentPosition!=null ? Text(_currentAddress) :SizedBox(height: 0.1,)

              ],
            ),
            SizedBox(height: 16,),

            TextField(
              controller: locationController,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              maxLength: 1000,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.45))
                ),
                hintStyle: Heading3(
                  Color.fromRGBO(0, 0, 0, 0.45),
                ),
                border: InputBorder.none,
                hintText: 'Location',
              ),
              onChanged: (text){
                setState(() {
                  _location = text;
                });
              },
            ),
            SizedBox(height: 16,),
//            createComplaintButton(db),
            createButton(db),
          ],
        ),
      ),
    );
  }
   Widget createButton(DatabaseService db){

    return _buttonflag==1 ? InkWell(
      onTap:(){
        _getCurrentLocation();
        setState(() {
          _buttonflag =0;
          _buttontext="CREATE";

        }

        );
      },
      child:Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primarygreen,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(_buttontext,style: Heading4(Colors.white),),
        ),
      ),
    )
        :createComplaintButton(db);



   }

  Widget createComplaintButton(DatabaseService db){

    return _loading ? Loading() : InkWell(
      splashColor: Colors.transparent,
      onTap: () async{
        //disable the button and show loading animation
        setState(() {
          _loading = true;
        });

        // TODO: validation for all dropdown and desc
        if(true){
          String uid = await _auth.getCurrentUID();
          String loc;
          if (locationController.text.isEmpty){
            loc=_currentAddress;
          }
          else{
            loc=locationController.text;
          }

          Random random = new Random();
          String cid = random.nextInt(99999999).toString();
          Complaint _complaint = new Complaint(
            departmentName: widget.selectedValueMap['department'],
            complaintType: widget.selectedValueMap['complaint'],
            description: widget.description,
            status: 'RAISED',
            uid: uid.toString(),
            location: loc,
            // TODO : add this datetime with trimmed value
            start: DateTime.now().toString().substring(0,16),
            end: null,
            verification: null,
            assignedBy: null,
            assignedTo: [],
            upvote: 0,
          );

          // TODO: update location in DB i.e. complaint/uid/Region
          // code here

          //creating document for new complaint in DATABASE
          await db.complaint.document(uid.toString()).collection(uid.toString()).document(cid.toString()).setData(_complaint.toJson());
          await db.allComplaints.document(region).collection(region).document(cid.toString()).setData(_complaint.toJson());
          //adding image to STORAGE
          db.uploadImageToFirebase(context,widget.imageFile,cid.toString());
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
          child: Text(_buttontext,style: Heading4(Colors.white),),
        ),
      ),
    );
  }
}

// name locality sublocality  administrativearea subadminarea throughfare country postalcode