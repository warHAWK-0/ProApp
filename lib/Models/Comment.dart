class Comment{
  String name, commentdes, date;


  Comment({
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