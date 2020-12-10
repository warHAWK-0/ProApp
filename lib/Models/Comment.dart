class CommentModel{
  String name, commentdes, date;


  CommentModel({
    this.name,
    this.commentdes,
    this.date
  });



  Map<String, dynamic> toJson() => {
    'Name': name,
    'Description': commentdes,
    'DateTime': date,

  };
}