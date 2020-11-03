class Complaint{
  String complaintId;
  String departmentName;
  String description;
  String attachmentURL;
  String status;
  String uid;
  String location;
  DateTime start,end,verification,assigned;

  Complaint({
    this.complaintId,
    this.departmentName,
    this.description,
    this.attachmentURL,
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
    'Description' : description,
    'Attachment' : attachmentURL,
    'Status' : status,
    'UID' : uid,
    'Location' : location,
    'Start' : start,
    'End' : end,
    'Verification' : verification,
    'Assigned' : assigned,
  };
}