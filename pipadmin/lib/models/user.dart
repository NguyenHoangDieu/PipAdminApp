class User {
  String? phone;
  String? password;
  String? accessToken;
  String? refreshToken;
  UserInfo? userInfo;

  User({this.accessToken, this.refreshToken, this.userInfo});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? phone;
  String? role;
  String? sId;

  UserInfo({this.phone, this.role, this.sId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    role = json['role'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['_id'] = this.sId;
    return data;
  }
}