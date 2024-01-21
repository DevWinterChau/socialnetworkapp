class PostModelRequest {
  final String title;
  final String content;
  final String? publishDate;

  PostModelRequest({
    required this.publishDate,
    required this.title,
    required this.content,
  } );

  // Convert the object to a map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'publishDate' : publishDate
    };
  }
}
