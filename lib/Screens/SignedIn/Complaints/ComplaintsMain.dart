import 'package:proapp/Screens/SignedIn/Complaints/Template/CreateComplaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import 'Template/MyCmplaints.dart';
import 'package:flutter/material.dart';
import 'Template/AllComplaint.dart';

class ComplaintMain extends StatefulWidget {
  final String uid;

  const ComplaintMain({Key key, this.uid}) : super(key: key);
  @override
  _ComplaintMainState createState() => _ComplaintMainState();
}

class _ComplaintMainState extends State<ComplaintMain> {
  bool _myComplaint = true;
  String dept, comp, desc;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Complaints',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        elevation: true,
        backIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: SingleChildScrollView(
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
                          color: _myComplaint ? Colors.grey[50] : Colors.white,
                          width: (MediaQuery.of(context).size.width - 1) / 2,
                          height: 60,
                          child: Center(
                              child: Text(
                            'My Complaints',
                            style: _myComplaint ? Heading3(primarygreen,fontWeight: FontWeight.w500) : Heading3(Colors.black,fontWeight: FontWeight.w400),
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
                          color: !_myComplaint ? Colors.grey[50] : Colors.white,
                          width: (MediaQuery.of(context).size.width - 1) / 2,
                          height: 60,
                          child: Center(
                            child: Text(
                              'All',
                              style: !_myComplaint ? Heading3(primarygreen,fontWeight: FontWeight.w500) : Heading3(Colors.black,fontWeight: FontWeight.w400),
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
              _myComplaint ? MyComplaint(uid: widget.uid,) : AllComplaint(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primarygreen,
        label: _myComplaint ? Text('CREATE') : Text('FILTER',style: TextStyle(color: Colors.white),),
        icon: _myComplaint
            ? Icon(
                Icons.add,
                color: Colors.white,
              )
            : Icon(
                Icons.filter,
                color: Colors.white,
              ),
        onPressed: () {
          print(widget.uid);
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
