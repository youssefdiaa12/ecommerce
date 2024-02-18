/// name : "dada"
/// email : "dada12@gmail.com"
/// password : "dada123"
/// rePassword : "dada123"
/// phone : "01010700701"

class forgetPasswordRequest {
  forgetPasswordRequest({
    this.email,
   });

  forgetPasswordRequest.fromJson(dynamic json) {
    email = json['email'];

  }

  String? email;
  forgetPasswordRequest copyWith({
    String? email,
    String? password,
  }) => forgetPasswordRequest(
    email: email ?? this.email,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

}