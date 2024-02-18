/// name : "dada"
/// email : "dada12@gmail.com"
/// password : "dada123"
/// rePassword : "dada123"
/// phone : "01010700701"

class resetPasswordRequest {
  resetPasswordRequest({
    this.email,
    this.newPassword,});

  resetPasswordRequest.fromJson(dynamic json) {
    email = json['email'];
    newPassword = json['newPassword'];
  }

  String? email;
  String? newPassword;
  resetPasswordRequest copyWith({
    String? email,
    String? password,
  }) => resetPasswordRequest(
    email: email ?? this.email,
    newPassword: password ?? newPassword,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['newPassword'] = newPassword;
    return map;
  }

}