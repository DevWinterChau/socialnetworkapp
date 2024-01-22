class PostModelReponse {
  List<Post>? data;
  bool? success;
  String? message;

  PostModelReponse({this.data, this.success, this.message});

  PostModelReponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Post>[];
      json['data'].forEach((v) {
        data!.add(new Post.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Post {
  int? id;
  String? title;
  String? content;
  String? publishDate;
  List<Images>? images;

  Post({this.id, this.title, this.content, this.publishDate, this.images});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    publishDate = json['publishDate'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['publishDate'] = this.publishDate;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? imageUrl;
  int? newsId;
  Null? news;

  Images({this.id, this.imageUrl, this.newsId, this.news});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    newsId = json['newsId'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['newsId'] = this.newsId;
    data['news'] = this.news;
    return data;
  }
}
