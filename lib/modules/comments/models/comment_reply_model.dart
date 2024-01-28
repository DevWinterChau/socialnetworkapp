class CommentReplyRequestModel {
  String nameActor;
  String comment;
  DateTime created;
  int newsId;
  int commentIdReplay;

  CommentReplyRequestModel({
    required this.nameActor,
    required this.comment,
    required this.created,
    required this.newsId,
    required this.commentIdReplay,
  });

  factory CommentReplyRequestModel.fromJson(Map<String, dynamic> json) {
    return CommentReplyRequestModel(
      nameActor: json['nameActor'],
      comment: json['comment'],
      created: DateTime.parse(json['created']),
      newsId: json['newsId'],
      commentIdReplay: json['commnetIdReplay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameActor': nameActor,
      'comment': comment,
      'created': created.toIso8601String(),
      'newsId': newsId,
      'commnetIdReplay': commentIdReplay,
    };
  }
}