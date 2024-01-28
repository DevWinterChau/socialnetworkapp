class RegisterModel {
  String? fullname;
  String? email;
  String? phoneNumber;
  String? gmail_token;
  RegisterModel({this.fullname, this.email, this.phoneNumber, this.gmail_token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gmail_token'] = this.gmail_token;
    return data;
  }
}
