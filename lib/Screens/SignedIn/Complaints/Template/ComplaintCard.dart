import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintExpanded.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:intl/intl.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final String uid;
  final List likedComplaint;

  TextStyle complaintCardSubHeading = GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  TextStyle complaintCardHeading = GoogleFonts.inter(
      textStyle: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ));

  ComplaintCard({Key key, this.complaint, this.uid, this.likedComplaint})
      : super(key: key);

  _getCurrentUpvoteBoolean() {
    return complaint.likedByUsers.contains(uid);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ComplaintExpanded(complaint: complaint, uid: uid)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8),
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  complaint.departmentName,
                  style: complaintCardSubHeading,
                ),
                Spacer(),
                VoteTemplate(
                  uid: uid,
                  compaintId: complaint.complaintId,
                  upvote: _getCurrentUpvoteBoolean(),
                  type: VoteType.complaintCard,
                  upvoteCount: complaint.upvote,
                ),
              ],
            ),
            SizedBox(
              height: 2.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.35,
              child: Text(
                complaint.complaintType,
                softWrap: true,
                style: complaintCardHeading,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Tag(
                  color: Colors.red,
                  text: complaint.status,
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
              height: 10,
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }

  //formatting DATE AND TIME
  String datefor() {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = DateTime.parse(complaint.start + ":00Z");
    if (!localDateTime.difference(justNow).isNegative) {
      if (complaint.start.toString().substring(11, 13).compareTo("12") > 0) {
        return complaint.start.toString().substring(11, 16);
      } else {
        return complaint.start.toString().substring(11, 16);
      }
    }
    String roughTimeString = DateFormat('jm').format(now);
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }
    return localDateTime.toString().substring(8, 10) +
        localDateTime.toString().substring(4, 8) +
        localDateTime.toString().substring(0, 4);
  }
}
