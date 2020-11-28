import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintCard.dart';
import 'package:proapp/Services/database.dart';

class AllComplaint extends StatefulWidget {
final String region;
  final String uid;

  const AllComplaint({Key key, this.uid, this.region}) : super(key: key);

  @override
  _AllComplaintState createState() => _AllComplaintState();
}

class _AllComplaintState extends State<AllComplaint> {
  DatabaseService db = new DatabaseService();

  Widget _noCompalaintFoundContainer(){

    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 300.0,
        height: 500.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/img/no_complaint_found_all.png'),
                fit: BoxFit.fill
            )
        ),
      ),
    );

  }


  @override
  Widget build(BuildContext context) {

    return   Expanded(
      child: StreamBuilder<QuerySnapshot>(

    stream: Firestore.instance.collection("AllComplaints").document(widget.region).collection(widget.region).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return SpinKitChasingDots(
              color: Colors.black,
              size: 30,
            );
          }
          else{
            return snapshot.data.documents.length == 0 ? _noCompalaintFoundContainer() :
            // map complaints to complaint card
            ListView.builder(
//                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context ,index){
                  return ComplaintCard(
                    complaint: Complaint(
                      complaintType: snapshot.data.documents[index]['ComplaintType'],
                      complaintId : snapshot.data.documents[index].documentID,
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
                    uid: widget.uid,
                  );
                }
            );
          }
        },
      ),

    );
  }
}
