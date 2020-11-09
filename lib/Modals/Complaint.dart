class Complaint{
  String complaintId;
  String departmentName;
  String complaintType;
  String description;
  String attachmentURL;
  String status;
  String uid;
  String location;
  String assigned;
  DateTime start,end,verification;

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
    this.assigned
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
    'Assigned' : assigned,
  };
}
