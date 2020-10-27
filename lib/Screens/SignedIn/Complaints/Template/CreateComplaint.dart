import 'package:flutter/material.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';

class CreateComplaint extends StatefulWidget {
  @override
  _CreateComplaintState createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Create Complaint',
          // style: blackBoldLargeStyle,
        ),
        elevation: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,16, 8, 12),
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
