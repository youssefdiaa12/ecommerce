/// currentPassword : "123456"
/// password : "pass1234"
/// rePassword : "pass1234"

class UpdatePassRequest {
  UpdatePassRequest({
      this.currentPassword, 
      this.password, 
      this.rePassword,});

  UpdatePassRequest.fromJson(dynamic json) {
    currentPassword = json['currentPassword'];
    password = json['password'];
    rePassword = json['rePassword'];
  }
  String? currentPassword;
  String? password;
  String? rePassword;
UpdatePassRequest copyWith({  String? currentPassword,
  String? password,
  String? rePassword,
}) => UpdatePassRequest(  currentPassword: currentPassword ?? this.currentPassword,
  password: password ?? this.password,
  rePassword: rePassword ?? this.rePassword,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPassword'] = currentPassword;
    map['password'] = password;
    map['rePassword'] = rePassword;
    return map;
  }

}