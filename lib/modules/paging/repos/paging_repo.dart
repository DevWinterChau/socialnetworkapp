import 'package:socialnetworkapp/providers/api_provider.dart';

import '../models/paging_model.dart';

abstract class PagingRepo<T> {
  final _apiProvider = ApiProvider();
  String get url;
  PagingModel? paging;
  // nếu khác nnull là false
  bool get isFirstPage => (paging?.paging?.cursor! ?? 0) == true;
  bool get hasNext => paging?.paging?.hasNext ?? true;
  int get cursor => paging?.paging?.cursor ?? 0;
  int get limit => paging?.paging?.limit ?? 0;
  int get total => paging?.paging?.total ?? 0;

  // hàm load more
  Future<List<T>> getData({Map<String, dynamic>? queryObject}) async {
    List<T> data = [];
    if (hasNext == false) {
      return <T>[];
    }
    print(url);

    final res = await _apiProvider.get(
      url,
      queryParameters: queryObject ?? {"cursor": cursor },
    );
    print(res);
    if (res.data['paging'] != null) {
      paging = PagingModel.fromJson(res.data);
      if (res.data['data'] != null && res.data['data'] is List) {
        final dataList = res.data['data'];
        data = dataList.map<T>((json) => parseJson(json)).toList();
      }
    }

    return data;
  }

  T parseJson(Map<String, dynamic> json);

  void refresh() {
    paging = null;
  }
}
