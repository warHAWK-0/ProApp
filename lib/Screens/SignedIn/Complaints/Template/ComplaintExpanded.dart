import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:intl/intl.dart';

class ComplaintExpanded extends StatefulWidget {
  final Complaint complaint;
  final String uid;

  const ComplaintExpanded({Key key, this.complaint,this.uid}) : super(key: key);
  @override
  _ComplaintExpandedState createState() => _ComplaintExpandedState();
}

class _ComplaintExpandedState extends State<ComplaintExpanded> {
  TextStyle complaintCardHeading = GoogleFonts.inter(
      textStyle: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ));

  TextStyle complaintCardSubHeading = GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  TextStyle blackBoldLargeStyle = GoogleFonts.inter(
      textStyle: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          "Complaint - "+widget.complaint.complaintId,
          style: blackBoldLargeStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.complaint.departmentName,
                  style: complaintCardSubHeading,
                ),
                Spacer(),
                VoteTemplate(type: VoteType.complaintCard, upvoteCount: 254)
              ],
            ),
            Text(
              widget.complaint.complaintType,
              style: complaintCardHeading,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Tag(
                  color: Colors.red,
                  text: widget.complaint.status,
                  textColor: Colors.white,
                  type: TagType.DEFAULT,
                ),
                Spacer(),
                Text(
                datefor(),
                  style: complaintCardSubHeading,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.complaint.description,
              style: complaintCardSubHeading,
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width / 3 >= 122
                      ? 122
                      : MediaQuery.of(context).size.width / 3,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide(color: primaryorange)),
                    color: primaryorange,
                    child: Row(
                      children: [
                        Icon(FlevaIcons.trash_2_outline, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text("DELETE",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontFamily: 'Intern',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                insetPadding: EdgeInsets.only(
                                    left: 16, top: 24, right: 16, bottom: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0)), //this right here
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 200.0,
                                  width: 328,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Center(
                                          child: Text(
                                              'Are you sure you want to delete complaint - '+widget.complaint.complaintId+" ?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        height: 46,
                                        width: 296,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              side: BorderSide(
                                                  color: Color(0xFFFF4128))),
                                          color: Color(0xFFFF4128),
                                          textColor: Colors.white,
                                          child: Text('DELETE',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontFamily: 'Intern',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          onPressed: () async{
                                            await Firestore.instance.collection("Complaint").document(widget.uid).collection(widget.uid).document(widget.complaint.complaintId).delete();
                                            Navigator.pop(context);
                                            Navigator.pop(context);

                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 46,
                                        width: 296,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              side: BorderSide(
                                                  color: Colors.white)),
                                          color: Colors.white,
                                          textColor: Color(0xFF718096),
                                          child: Text('CANCEL',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontFamily: 'Intern',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
  String datefor(){
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = DateTime.parse(widget.complaint.start+":00Z");
    if (!localDateTime.difference(justNow).isNegative) {
      if(widget.complaint.start.toString().substring(11,13).compareTo("12")>0){
        return widget.complaint.start.toString().substring(11,16);
      }
      else{return widget.complaint.start.toString().substring(11,16);}
    }
    String roughTimeString = DateFormat('jm').format(now);
    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }
    return localDateTime.toString().substring(8,10)+localDateTime.toString().substring(4,8)+localDateTime.toString().substring(0,4);
  }
}
