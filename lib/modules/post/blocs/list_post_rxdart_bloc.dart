import 'package:socialnetworkapp/modules/paging/blocs/paging_data_bloc.dart';
import 'package:socialnetworkapp/modules/paging/repos/paging_repo.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';
import 'package:socialnetworkapp/modules/post/repos/list_post_paging_repo.dart';

class ListPostRxDartBloc  extends PagingDataBehaviorBloc<Post>{
  Stream<List<Post>?> get postStream => pagingdataStream;
  final ListPostPageRepo _repo;
  ListPostRxDartBloc(this._repo);

  Future<void> getPost() {
    return getData();
  }
  Future<void> reloadPost() {
    return reloadData();
  }

  @override
  PagingRepo get dataPagingRepo => _repo;

  @override
  void dispose() {
  }

}