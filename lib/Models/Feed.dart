class Feed{
  String datetime, description, name, tag, type, uid, postid;
  int downvote, upvote;
  Map options;

  Feed({
    this.uid,
    this.name,
    this.type,
    this.datetime,
    this.description,
    this.downvote,
    this.options,
    this.postid,
    this.tag,
    this.upvote

  });

  Map<String, dynamic> toJson() => {
    'DateTime' : datetime,
    'Description' :description,
    'Downvote':downvote,
    'Name':name,
    'Options':options,
    'Tag':tag,
    'Type':type,
    'Upvote':upvote,
    'uid':uid,

  };




}



