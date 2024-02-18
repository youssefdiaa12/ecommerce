import '../User/User.dart';
import 'UserDto.dart';

/// message : "success"
/// user : {"name":"dada","email":"dada12@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Y2U3NzUxMTc0ZmY4MTJhNjAzNmU1NCIsIm5hbWUiOiJkYWRhIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MDgwMjk3NzgsImV4cCI6MTcxNTgwNTc3OH0.r3aQhKgzf9ftKGBYKUSdzwLRNMctM-_KutHL0eCk8Ao"

class RegisterResponse {
  RegisterResponse({
      this.message, 
      this.user, 
      this.token,});

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  UserDto? user;
  String? token;
RegisterResponse copyWith({  String? message,
  UserDto? user,
  String? token,
}) => RegisterResponse(  message: message ?? this.message,
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
  toUser() {
    if(user==null){
      return null;
    }
    return User(
      name: user?.name,
      email: user?.email,
      role: user?.role,
      token: token,
    );
  }

}