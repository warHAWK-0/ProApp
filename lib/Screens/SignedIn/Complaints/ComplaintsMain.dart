import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/CreateComplaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import 'Template/MyCmplaints.dart';
import 'package:flutter/material.dart';
import 'Template/AllComplaint.dart';

class ComplaintMain extends StatefulWidget {
  @override
  _ComplaintMainState createState() => _ComplaintMainState();
}

class _ComplaintMainState extends State<ComplaintMain> {
  bool _myComplaint = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Complaints',
          // style: blackBoldLargeStyle,
        ),
        elevation: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              ]),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _myComplaint = true;
                        });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 1) / 2,
                        height: 60,
                        child: Center(
                            child: Text(
                          'My Complaints',
                          //style: _myComplaint ? subHeadingSelected : subHeadingBlack,
                        )),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _myComplaint = false;
                        });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 1) / 2,
                        height: 60,
                        child: Center(
                          child: Text(
                            'All',
                            //style: !_myComplaint ? subHeadingSelected : subHeadingBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _myComplaint ? MyComplaint() : AllComplaint(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarygreen,
        child: _myComplaint
            ? Icon(
                Icons.add,
                color: Colors.white,
              )
            : Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
        onPressed: () {
          _myComplaint
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateComplaint()))
              : Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Filter()));
        },
      ),
    );
  }
}
