import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintCard.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/themes.dart';

class MyComplaint extends StatefulWidget {
  final String uid;

  const MyComplaint({Key key, this.uid}) : super(key: key);
  @override
  _MyComplaintState createState() => _MyComplaintState();
}

class _MyComplaintState extends State<MyComplaint> {
  DatabaseService db = new DatabaseService();
  Auth auth = new AuthService();

  _showFetchComplaintContainer(){
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SpinKitCubeGrid(
            color: primarygreen,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Fetching your complaints...',
            style: Heading4(Colors.grey[400]),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _noCompalaintFoundContainer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/7,),
          Container(
            height: MediaQuery.of(context).size.width/1.17,
            width: MediaQuery.of(context).size.width/1.17,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/img/no_complaint_found.png'),
                    fit: BoxFit.fill
                )
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('current uid is: '+widget.uid);
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Complaint").document(widget.uid).collection(widget.uid).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return _showFetchComplaintContainer();
          }
          else{
            print(snapshot.data.documents[0]['ComplaintType']);
            return snapshot.data.documents.length == 0 ? _noCompalaintFoundContainer() :
            // map complaints to complaint card
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context ,index){
                  return ComplaintCard(
                  complaint: Complaint(
                    complaintType: snapshot.data.documents[index]['ComplaintType'],
                    complaintId : snapshot.data.documents[index]['ComplaintId'],
                    departmentName : snapshot.data.documents[index]['DepartmentName'],
                    description : snapshot.data.documents[index]['Description'],
                    status : snapshot.data.documents[index]['Status'],
                    uid : snapshot.data.documents[index]['UID'],
                    location : snapshot.data.documents[index]['Location'],
                    start : snapshot.data.documents[index]['Start'],
                    end : snapshot.data.documents[index]['End'],
                    verification : snapshot.data.documents[index]['Verification'],
                    assigned : snapshot.data.documents[index]['Assigned'],
                  ),
                );
                }
              );
          }
        },
      ),
    );
  }
}