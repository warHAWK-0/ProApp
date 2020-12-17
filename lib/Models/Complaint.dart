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
  String start,end,verification;
  Map assigned;
  List<dynamic> likedByUsers;

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
    this.assigned,
    this.upvote,
    this.likedByUsers,
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
    'Upvote': upvote,
    'LikedByUsers' : likedByUsers,
  };
}