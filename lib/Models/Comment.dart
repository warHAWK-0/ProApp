class CommentModel{
  String name, commentdes, date;
  var flaggedUid;


  CommentModel({
    this.name,
    this.commentdes,
    this.date,
    this.flaggedUid
  });



  Map<String, dynamic> toJson() => {
    'Name': name,
    'Description': commentdes,
    'DateTime': date,
    'FlaggedUid':flaggedUid

  };
}