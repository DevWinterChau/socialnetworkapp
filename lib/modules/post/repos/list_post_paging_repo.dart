import 'package:socialnetworkapp/modules/paging/repos/paging_repo.dart';

import '../models/PostReadRequest.dart';

class ListPostPageRepo extends PagingRepo<Post>{
  @override
  Post parseJson(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  // TODO: implement url
  String get url => 'news';

}