/// name : "dada"
/// email : "dada12@gmail.com"
/// password : "dada123"
/// rePassword : "dada123"
/// phone : "01010700701"

class LoginRequest {
  LoginRequest({
    this.email,
    this.password,});

  LoginRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }

  String? email;
  String? password;
  LoginRequest copyWith({
    String? email,
    String? password,
  }) => LoginRequest(
    email: email ?? this.email,
    password: password ?? this.password,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}