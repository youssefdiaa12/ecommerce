import 'User.dart';

/// message : "success"
/// user : {"name":"Ahmed Abd Al-Muti","email":"ahmedmutt2i2488@gmail.com","role":"user"}

class UpdateLoggedUserDataResponse {
  UpdateLoggedUserDataResponse({
      this.message, 
      this.user,});

  UpdateLoggedUserDataResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  User? user;
UpdateLoggedUserDataResponse copyWith({  String? message,
  User? user,
}) => UpdateLoggedUserDataResponse(  message: message ?? this.message,
  user: user ?? this.user,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}