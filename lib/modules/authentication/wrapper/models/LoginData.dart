class LoginData {
  Data? data;
  bool? success;
  String? message;

  LoginData({this.data, this.success, this.message});

  LoginData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? accessToken;
  String? expiration;
  bool? isNew;
  Data({this.accessToken, this.expiration, this.isNew});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiration = json['expiration'];
    isNew = json['isNew'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiration'] = this.expiration;
    data['isNew'] = this.isNew;
    return data;
  }
}
