class Complaint{
  String complaintId;
  String departmentName;
  String complaintType;
  String description;
  String attachmentURL;
  String status;
  String uid;
  num upvote;
  String location;
  String start,end,verification,assignedBy;
  List assignedTo;

  Complaint({
    this.complaintId,
    this.departmentName,
    this.complaintType,
    this.description,
    this.status,
    this.uid,
    this.location,
    this.start,
    this.end,
    this.verification,
    this.assignedBy,
    this.upvote,
    this.assignedTo
  });

  Map<String, dynamic> toJson() => {
    'ComplaintId' : complaintId,
    'DepartmentName' : departmentName,
    'ComplaintType' : complaintType,
    'Description' : description,
    'Status' : status,
    'UID' : uid,
    'Location' : location,
    'Start' : start,
    'End' : end,
    'Verification' : verification,
    'AssignedBy' : assignedBy,
    'Upvote': upvote,
    'AssignedTo' : assignedTo,

  };
}