import 'dart:io';

import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:proapp/Screens/SignedIn/Complaints/Template/ConfirmLocation.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/ToastMessage.dart';

import 'package:proapp/Widgets/themes.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';



class CreateComplaint extends StatefulWidget {
  @override
  _CreateComplaintState createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  File _imageFile;
  final picker = ImagePicker();
  Map<String, String> selectedValueMap = Map();
  String _description;
  Color descColor = Colors.grey[300];

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
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 75,maxHeight: 600,maxWidth: 600);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future pickGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 75, maxWidth: 600,maxHeight: 600);

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

  DatabaseService _initiateDBService() => new DatabaseService();



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

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.grey[300],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: TextField(
                  //controller: myController3,
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
              _imageFile == null ? InkWell(
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
              ) : Stack(

                children: [Container(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                  height: MediaQuery.of(context).size.width/3,
                  width: MediaQuery.of(context).size.width/2,
                  child: new Image.file(_imageFile),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width/2-65,
                  bottom: MediaQuery.of(context).size.width/3-25,
                  child: InkWell(

                      child: Icon(FlevaIcons.close_circle,size:25 ,color: Color(0xff404040),),
                  onTap:() {
                    setState(() {
                      _imageFile=null;
                    });
                  },),
                )],
              ),

              SizedBox(height: _height/50,),

              InkWell(
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primarygreen,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text('CONTINUE',style: Heading4(Colors.white),),
                  ),
                ),
                onTap: (){
                  if(selectedValueMap["department"]!=null && selectedValueMap["complaint"]!=null && _description.isNotEmpty){
                    Navigator.push(context , MaterialPageRoute(builder: (context)=> ConfirmLocation(description: _description,selectedValueMap: selectedValueMap,imageFile: _imageFile,)));
                  }
                  else{
                    ToastUtils.showCustomToast(
                        context, "An error has occurred, please recheck and do no leave anything blank");
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

