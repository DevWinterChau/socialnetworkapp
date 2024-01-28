class CommentModelResponse {
  List<Data>? data;
  bool? success;
  String? message;
  Paging? paging;

  CommentModelResponse({this.data, this.success, this.message, this.paging});

  CommentModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    paging =
    json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class Data {
  int? idComment;
  String? nameActor;
  String? comment;
  String? created;
  int? newsId;
  List<CommentsReplay>? commentsReplay;

  Data(
      {this.nameActor,
        this.comment,
        this.created,
        this.newsId,
        this.commentsReplay});

  Data.fromJson(Map<String, dynamic> json) {
    idComment = json['idComment'];
    nameActor = json['nameActor'];
    comment = json['comment'];
    created = json['created'];
    newsId = json['newsId'];
    if (json['commentsReplay'] != null) {
      commentsReplay = <CommentsReplay>[];
      json['commentsReplay'].forEach((v) {
        commentsReplay!.add(new CommentsReplay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idComment'] = this.idComment;
    data['nameActor'] = this.nameActor;
    data['comment'] = this.comment;
    data['created'] = this.created;
    data['newsId'] = this.newsId;
    if (this.commentsReplay != null) {
      data['commentsReplay'] =
          this.commentsReplay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentsReplay {
  int? idComment;
  String? nameActor;
  String? comment;
  String? created;
  int? newsId;
  Null? news;
  Null? commentsReplay;

  CommentsReplay(
      {this.idComment,
        this.nameActor,
        this.comment,
        this.created,
        this.newsId,
        this.news,
        this.commentsReplay});

  CommentsReplay.fromJson(Map<String, dynamic> json) {
    idComment = json['idComment'];
    nameActor = json['nameActor'];
    comment = json['comment'];
    created = json['created'];
    newsId = json['newsId'];
    news = json['news'];
    commentsReplay = json['commentsReplay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idComment'] = this.idComment;
    data['nameActor'] = this.nameActor;
    data['comment'] = this.comment;
    data['created'] = this.created;
    data['newsId'] = this.newsId;
    data['news'] = this.news;
    data['commentsReplay'] = this.commentsReplay;
    return data;
  }
}

class Paging {
  int? cursor;
  int? nextCursor;
  int? total;
  int? page;
  int? limit;
  bool? hasNext;

  Paging(
      {this.cursor,
        this.nextCursor,
        this.total,
        this.page,
        this.limit,
        this.hasNext});

  Paging.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    nextCursor = json['nextCursor'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    hasNext = json['hasNext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    data['nextCursor'] = this.nextCursor;
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['hasNext'] = this.hasNext;
    return data;
  }
}
