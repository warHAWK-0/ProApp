import 'package:proapp/Models/Filter.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/CreateComplaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import 'Template/MyCmplaints.dart';
import 'package:flutter/material.dart';
import 'Template/AllComplaint.dart';

class ComplaintMain extends StatefulWidget {
  final String uid;
  bool myComplaint;
  Filter filter;

  ComplaintMain({Key key, this.uid, this.myComplaint = true, this.filter})
      : super(key: key);
  @override
  _ComplaintMainState createState() => _ComplaintMainState();
}

class _ComplaintMainState extends State<ComplaintMain> {
  String dept, comp, desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Complaints',
          style: Heading2(Colors.black, letterSpace: 1.25),
        ),
        elevation: true,
        backIcon: false,
      ),
      body: Column(
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
                        widget.myComplaint = true;
                      });
                    },
                    child: Container(
                      color:
                          widget.myComplaint ? Colors.grey[50] : Colors.white,
                      width: (MediaQuery.of(context).size.width - 1) / 2,
                      height: 60,
                      child: Center(
                          child: Text(
                        'My Complaints',
                        style: widget.myComplaint
                            ? Heading3(primarygreen,
                                fontWeight: FontWeight.w500)
                            : Heading3(Colors.black,
                                fontWeight: FontWeight.w400),
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
                        widget.myComplaint = false;
                      });
                    },
                    child: Container(
                      color:
                          !widget.myComplaint ? Colors.grey[50] : Colors.white,
                      width: (MediaQuery.of(context).size.width - 1) / 2,
                      height: 60,
                      child: Center(
                        child: Text(
                          'All',
                          style: !widget.myComplaint
                              ? Heading3(primarygreen,
                                  fontWeight: FontWeight.w500)
                              : Heading3(Colors.black,
                                  fontWeight: FontWeight.w400),
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
          Expanded(
            child: widget.myComplaint
                ? MyComplaint(
                    uid: widget.uid,
                  )
                : AllComplaint(
                    uid: widget.uid,
                  ),
          ),
        ],
      ),

      //),
      floatingActionButton: widget.myComplaint ? FloatingActionButton.extended(
        backgroundColor: primarygreen,
        label: Text('CREATE'),
        icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateComplaint(
                            uid: widget.uid,
                          )));
        },
      ) : Container(),
    );
  }
}
