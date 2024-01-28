class CommentCreateModel {
  String nameActor;
  String comment;
  DateTime created;
  int newsId;

  CommentCreateModel({
    required this.nameActor,
    required this.comment,
    required this.created,
    required this.newsId,
  });

  factory CommentCreateModel.fromJson(Map<String, dynamic> json) {
    return CommentCreateModel(
      nameActor: json['nameActor'],
      comment: json['comment'],
      created: DateTime.parse(json['created']),
      newsId: json['newsId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameActor': nameActor,
      'comment': comment,
      'created': created.toIso8601String(),
      'newsId': newsId,
    };
  }
}
