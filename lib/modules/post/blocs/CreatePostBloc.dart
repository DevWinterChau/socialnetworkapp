import 'package:dio/dio.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';

import '../../../providers/bloc_provider.dart';
import '../models/PostReqeustModel.dart';
import '../repos/CreatePostRepo.dart';

class CreatePostBloc extends BlocBase {
  final CreatePostRepo postRepo;
  CreatePostBloc(this.postRepo);
  Future<bool?> createPost(FormData request, Options options) async {
    final result = await postRepo.createPost(request, options);

    if(result == true){
      return true;
    }
    return false;
  }
  Future<PostModelReponse?> getAllPost() async {
    final result = await postRepo.getAllpost();
    if(result!.success == true){
      return result;
    }
    return null;
  }

  @override
  void dispose() {

  }
}
