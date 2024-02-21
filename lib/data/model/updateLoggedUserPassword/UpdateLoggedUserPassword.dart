import 'User.dart';

/// message : "success"
/// user : {"name":"Ahmed Abd Al-Muti","email":"ahmedmutt2i2488www@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Y2ZlMTdmYmZhMjJlNjVmZDE4ZDZhZCIsImlhdCI6MTcwODQ3NTQzNywiZXhwIjoxNzE2MjUxNDM3fQ.3Usx0mk3r3d6Wonix3b6qBwTvT7nzual7noGr-xTlFA"

class UpdateLoggedUserPassword {
  UpdateLoggedUserPassword({
      this.message, 
      this.user, 
      this.token,});

  UpdateLoggedUserPassword.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  User? user;
  String? token;
UpdateLoggedUserPassword copyWith({  String? message,
  User? user,
  String? token,
}) => UpdateLoggedUserPassword(  message: message ?? this.message,
  user: user ?? this.user,
  token: token ?? this.token,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}