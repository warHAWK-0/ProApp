import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class CreateComplaint extends StatefulWidget {
  @override
  _CreateComplaintState createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
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
  Map<String, String> selectedValueMap = Map();

  @override
  void initState() {
    selectedValueMap["department"] = null;
    selectedValueMap["complaint"] = null;
    super.initState();
  }

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
                ),
              ),
              SizedBox(height: _height/50,),
              Container(
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
              InkWell(
                splashColor: Colors.transparent,
                onTap: (){},
                child: Container(
                  height: 45,
                  width: _width,
                  decoration: BoxDecoration(
                    color: primarygreen,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text('CREATE',style: Heading4(Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
