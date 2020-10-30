import 'package:flutter/material.dart';

class AllComplaint extends StatefulWidget {
  @override
  _AllComplaintState createState() => _AllComplaintState();
}

class _AllComplaintState extends State<AllComplaint> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            Container(
              height: MediaQuery.of(context).size.width/1.17,
              width: MediaQuery.of(context).size.width/1.17,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/img/no_complaint_found_all.png'),
                  fit: BoxFit.fill
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
