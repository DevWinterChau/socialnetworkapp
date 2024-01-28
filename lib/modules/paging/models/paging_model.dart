class PagingModel {
  Paging? paging;

  PagingModel({this.paging});

  PagingModel.fromJson(Map<String, dynamic> json) {
    paging =  json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class Paging {
  int? cursor;
  int? nextCursor;
  int? total;
  int? page;
  int? limit;
  bool? hasNext;

  Paging(
      {this.cursor,
        this.nextCursor,
        this.total,
        this.page,
        this.limit,
        this.hasNext});

  Paging.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    nextCursor = json['nextCursor'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    hasNext = json['hasNext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    data['nextCursor'] = this.nextCursor;
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['hasNext'] = this.hasNext;
    return data;
  }
}
