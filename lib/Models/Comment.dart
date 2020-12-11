class CommentModel{
  String name, commentdes, date;
  var flagedUid;


  CommentModel({
    this.name,
    this.commentdes,
    this.date,
    this.flagedUid
  });



  Map<String, dynamic> toJson() => {
    'Name': name,
    'Description': commentdes,
    'DateTime': date,
    'FlagedUid':flagedUid

  };
}