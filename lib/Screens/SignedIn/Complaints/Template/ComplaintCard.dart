import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintExpanded.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';

class ComplaintCard extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintExpanded()));
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
                  'Department',
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
                'Complaint Complaint Comasdasdas fgszv efgak sjggdf gjgfAJfd',
                softWrap: true,
                style: complaintCardHeading,
              ),
            ),
            SizedBox(height: 16.0,),
            Row(
              children: [
                Tag(
                  color: Colors.red,
                  text: 'Raised',
                  textColor: Colors.white,
                  type: TagType.DEFAULT,
                ),
                Spacer(),
                Text(
                  'DD/MM/YYYY HH:MM PM',
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
