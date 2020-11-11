import 'dart:io';
import 'dart:math';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Modals/UserDetails.dart';

class CreateComplaint extends StatefulWidget {
  BaseAuth baseAuth;
  CreateComplaint({Key key, this.baseAuth}) : super(key: key);
  @override
  _CreateComplaintState createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  bool _loading = false;
  File _imageFile;
  final picker = ImagePicker();
  Map<String, String> selectedValueMap = Map();
  String _description;

  final List<String> _department = [
    'Department 1',
    'Department 2',
    'Department 3'
  ];
  final List<String> _complaint = [
    'Complaint 101',
    'Complaint 012',
    'Complaint 201'
  ];


  @override
  void initState() {
    selectedValueMap["department"] = null;
    selectedValueMap["complaint"] = null;
    super.initState();
  }

  //Upload Image
  Future pickCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future pickGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  //searchable dropdown layout
  Widget getSearchableDropdown(List<String> listData, mapKey) {
    List<DropdownMenuItem> items = [];
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
        'Select ' + mapKey,
        // style: Heading3(
        //   Color.fromRGBO(0, 0, 0, 0.45),
        // ),
      ),
      searchHint: Text(
        'Select ' + mapKey,
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          selectedValueMap[mapKey] = value;
        });
      },
    );
  }

  DatabaseService _initiateDBService() => new DatabaseService(widget.baseAuth);

  Widget createComplaintButton(DatabaseService db){
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async{
        //disable the button and show loading animation
        setState(() {
          _loading = validateAllInputField() ? true : false;
        });

        Random cid = new Random();
        Complaint _complaint = new Complaint(
          complaintId: cid.nextInt(99999999).toString(),
          departmentName: selectedValueMap['department'],
          complaintType: selectedValueMap['complaint'],
          description: _description,
          status: 'RAISED',
          uid: widget.baseAuth.currentUser().toString(),
          location: null,
          start: null,
          end: null,
          verification: null,
          assigned: null,
        );

        //creating document for new complaint in DATABASE
        await db.complaintRef.document(widget.baseAuth.currentUser().toString()).setData(_complaint.toJson());
        //adding image to STORAGE
        db.uploadImageToFirebase(context,_imageFile);

        //set loading to false and pop the window
        //Also showing toast message as notification
        setState(() {
          _loading = false;
        });
        Navigator.pop(context);

      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primarygreen,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text('CREATE',style: Heading4(Colors.white),),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
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
                    Navigator.pop(context);
                    pickCameraImage();
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
                    Navigator.pop(context);
                    pickGalleryImage();
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

  bool validateAllInputField(){
    return _imageFile != null &&
        selectedValueMap["department"] != null &&
        selectedValueMap["complaint"] != null &&
        _description != null;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService db = _initiateDBService();
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Create a Complaint',
          style: Heading2(Colors.black,letterSpace: 1.0),
        ),
        elevation: true,
        backIcon: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,16, 8, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _height/45,),
              // Dropdown Search for Department
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[350],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: getSearchableDropdown(_department, "department"),
              ),
              SizedBox(height: _height/50,),
              // Dropdown Search for Complaint
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[350],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: getSearchableDropdown(_complaint,"complaint"),
              ),
              SizedBox(height: _height/50,),
              //Description Box
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[350],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    hintStyle: Heading3(
                      Color.fromRGBO(0, 0, 0, 0.45),
                    ),
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                  onChanged: (text){
                    setState(() {
                      _description = text;
                    });
                  },
                ),
              ),
              SizedBox(height: _height/50,),
              // Upload Button
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[350],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(FlevaIcons.upload,size: 24,color: Color.fromRGBO(0, 0, 0, 0.45),),
                      SizedBox(width: 4,),
                      Text(
                        'Upload',
                        style: Heading3(
                          Color.fromRGBO(0, 0, 0, 0.45),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 6,left: 4),
                child: Text(
                  'File Size condition',
                  style: Heading(
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                    fontSize: 13.0,
                  )
                ),
              ),
              SizedBox(height: _height/50,),
              // Button to create the complaint
              createComplaintButton(db),
            ],
          ),
        ),
      ),
    );
  }
}

