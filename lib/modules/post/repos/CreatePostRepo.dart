import 'package:socialnetworkapp/providers/api_provider.dart';

import '../models/PostReqeustModel.dart';

class CreatePostRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<bool?> createPost(PostModelRequest request) async {
    try {
      final response = await _apiProvider.post(
        "news",
        data: request,
      );

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
}
