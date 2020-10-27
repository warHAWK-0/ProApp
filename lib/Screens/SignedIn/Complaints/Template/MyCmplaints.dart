import 'package:flutter/material.dart';

class MyComplaint extends StatefulWidget {
  @override
  _MyComplaintState createState() => _MyComplaintState();
}

class _MyComplaintState extends State<MyComplaint> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            Container(
              height: MediaQuery.of(context).size.width/1.25,
              width: MediaQuery.of(context).size.width/1.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/img/no_complaint_found.png'),
                    fit: BoxFit.fill,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}