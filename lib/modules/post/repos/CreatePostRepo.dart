import 'package:dio/dio.dart';
import 'package:socialnetworkapp/providers/api_provider.dart';

import '../models/PostReadRequest.dart';
import '../models/PostReqeustModel.dart';

class CreatePostRepo {
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
  Future<PostModelReponse?> getAllpost() async {
    try {
      final response = await _apiProvider.get(
        "news",
      );
      print('response GetAllPost $response');
      if (response.statusCode == 200) {
        return PostModelReponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw UnimplementedError(
        'getAllpost() is not implemented with err = $e',
      );
    }
  }
}
