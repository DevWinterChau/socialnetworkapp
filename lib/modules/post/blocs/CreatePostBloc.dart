import '../../../providers/bloc_provider.dart';
import '../models/PostReqeustModel.dart';
import '../repos/CreatePostRepo.dart';

class CreatePostBloc extends BlocBase {
  final CreatePostRepo postRepo = CreatePostRepo();

  Future<bool?> createPostBloc(PostModelRequest request) async {
    // Use the correct method from the repository
    return postRepo.createPost(request);
  }

  @override
  void dispose() {
    // Dispose resources if needed
  }
}
