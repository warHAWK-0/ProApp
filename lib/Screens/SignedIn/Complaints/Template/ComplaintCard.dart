import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintExpanded.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;

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
      )
  );

  ComplaintCard({Key key, this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintExpanded(complaint: complaint,)));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
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
                    type: VoteType.complaintCard,
                    upvoteCount: 345
                ),
              ],
            ),
            SizedBox(height: 2.0,),
            Container(
              width: MediaQuery.of(context).size.width/1.35,
              child: Text(
                complaint.complaintType,
                softWrap: true,
                style: complaintCardHeading,
              ),
            ),
            SizedBox(height: 16.0,),
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
                  complaint.start.toString(),
                  style: complaintCardSubHeading,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
