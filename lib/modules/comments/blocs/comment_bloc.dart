import 'package:rxdart/rxdart.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_create_model.dart';
import 'package:socialnetworkapp/modules/paging/blocs/paging_data_bloc.dart';
import 'package:socialnetworkapp/modules/paging/repos/paging_repo.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';
import 'package:socialnetworkapp/modules/post/repos/list_post_paging_repo.dart';

import '../../../providers/bloc_provider.dart';
import '../models/comment_reply_model.dart';
import '../models/comment_response_model.dart';
import '../models/comment_response_model.dart';
import '../repos/comment_repo.dart';

class CommentRxDartBloc  extends BlocBase {
  final CommentRepo _repo;
  CommentRxDartBloc(this._repo);
  final stream = BehaviorSubject<CommentModelResponse?>.seeded(null);
  Stream<CommentModelResponse?> get commentStream => stream.stream;

  Future<CommentModelResponse?> getCommentsByNewsId(int newsId) async {
    print('Lấy comment từ newid $newsId');
    try {
      final results = await _repo.getCommentByNewsId(newsId);
      if (results != null && results.data != null) {
        print(results.data!);
        //
        // if (!stream.hasValue) {
        //   // Nếu stream chưa có giá trị, thêm giá trị đầu tiên
        //   stream.sink.add(results);
        // } else {
        //   // Nếu stream đã có giá trị, thêm kết quả mới vào stream
        //   stream.sink.add([
        //     ...(stream!.stream!.value! as CommentModelResponse?)?.data ?? [],
        //     ...(results!.data ?? []),
        //   ] as CommentModelResponse?);
        // }
        stream.sink.add(results);
        return results;
      }

      // Trả về null nếu không có dữ liệu hoặc lỗi
      return null;
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error in getCommentsByNewsId: $error');
      return null;
    }
  }
  Future<bool?> createComment (CommentCreateModel request)  async {
    final results = await _repo.createComment(request);
    if(results == true){
      return results;
    }
    return false;
  }
  Future<bool?> createCommentReply (CommentReplyRequestModel request)  async {
    final results = await _repo.createCommentReply(request);
    if(results == true){
      return results;
    }
    return false;
  }

  @override
  void dispose() {

  }

}