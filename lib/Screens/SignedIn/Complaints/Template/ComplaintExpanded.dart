import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:proapp/Widgets/themes.dart';

class ComplaintExpanded extends StatefulWidget {
  @override
  _ComplaintExpandedState createState() => _ComplaintExpandedState();
}

class _ComplaintExpandedState extends State<ComplaintExpanded> {
  TextStyle complaintCardHeading = GoogleFonts.inter(
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )
  );

  TextStyle complaintCardSubHeading = GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  TextStyle blackBoldLargeStyle= GoogleFonts.inter(
      textStyle:TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Complaint ##',
          style: blackBoldLargeStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Department",style: complaintCardSubHeading,),
                  Spacer(),
                  VoteTemplate(type: VoteType.complaintCard, upvoteCount: 254)
                ],
              ),
              Text("Type of complaint",style: complaintCardHeading,),
              SizedBox(height: 10,),
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
              SizedBox(height: 20,),
              Text("Lorem ipsum dolor sit amet, consecter ipiscing elit, sed do eiusmod tempor incididunt utbore Lorem ipsum dolor sit amet, consecter ipiscing elit, sed do eiusmod tempor incididunt utbore...Lorem ipsum dolor sit amet, consecter 240 characters.Lorem ipsum dolor sit amet, consecter ipiscing elit, sed do eiusmod tempor incididunt utbore Lorem ipsum dolor sit amet, consecter ipiscing elit, sed do eiusmod tempor incididunt utbore...Lorem ipsum dolor sit amet, consecter 240 characters",style: complaintCardSubHeading,),
              SizedBox(height: 76,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width/3 >= 122 ? 122 : MediaQuery.of(context).size.width/3,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                          side: BorderSide(color: primaryorange)
                      ),
                      color: primaryorange,
                      child: Row(
                        children: [
                          Icon(FlevaIcons.trash_2_outline,color:Colors.white),
                          SizedBox(width: 8,),
                          Text("DELETE",style: GoogleFonts.inter(textStyle:TextStyle(fontFamily: 'Intern',fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600))),
                        ],
                      ),
                      onPressed: ()  {
                        //cancel
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),

    );
  }
}
