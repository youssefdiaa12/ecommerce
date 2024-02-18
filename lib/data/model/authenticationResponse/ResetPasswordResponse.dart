/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YjdlNmE2ZDA2MTk0MDAzNGQyMDdhYSIsImlhdCI6MTcwODEyMDE5MiwiZXhwIjoxNzE1ODk2MTkyfQ.LzzutmbQF-KxJf6gxdOhvbSyOIsPw8qFtBNycrZtHC0"

class ResetPasswordResponse {
  ResetPasswordResponse({
      this.token,});

  ResetPasswordResponse.fromJson(dynamic json) {
    token = json['token'];
  }
  String? token;
ResetPasswordResponse copyWith({  String? token,
}) => ResetPasswordResponse(  token: token ?? this.token,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}