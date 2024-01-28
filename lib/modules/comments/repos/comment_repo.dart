import 'package:dio/dio.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_create_model.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_reply_model.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_response_model.dart';
import 'package:socialnetworkapp/providers/api_provider.dart';

class CommentRepo {
  final ApiProvider _apiProvider = ApiProvider();
  Future<bool?> createPost(FormData request, Options options) async {
    try {
      final response = await _apiProvider.post(
        "news",
        data: request,
        options: options,
      );
      print('response CreatePostRepo $response');
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw UnimplementedError(
        'CreatePostRepo() is not implemented with err = $e',
      );
    }
  }

  Future<CommentModelResponse?> getCommentByNewsId(int newsId) async {
    try {
      final response = await _apiProvider.get(
        "comment",
        queryParameters: {"newsId": newsId}
      );
      if (response.statusCode == 200) {
        return CommentModelResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw UnimplementedError(
        'getCommentByNewsId() is not implemented with err = $e',
      );
    }
  }

  Future<bool?> createCommentReply(CommentReplyRequestModel request) async {
    try {
      final response = await _apiProvider.post(
        "comment/replaycomment",
        data: request.toJson(),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['success'];
      }
      return false;
    } catch (e) {
      throw UnimplementedError(
        'createCommentReply() is not implemented with err = $e',
      );
    }
  }

  Future<bool?> createComment(CommentCreateModel request) async {
    try {
      final response = await _apiProvider.post(
          "comment",
           data: request.toJson(),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['success'];
      }
      return false;
    } catch (e) {
      throw UnimplementedError(
        'createComment() is not implemented with err = $e',
      );
    }
  }
}
