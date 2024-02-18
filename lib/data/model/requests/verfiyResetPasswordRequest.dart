/// name : "dada"
/// email : "dada12@gmail.com"
/// password : "dada123"
/// rePassword : "dada123"
/// phone : "01010700701"

class verfiyResetPasswordRequest {
  verfiyResetPasswordRequest({
    this.resetCode,
  });

  verfiyResetPasswordRequest.fromJson(dynamic json) {
    resetCode = json['resetCode'];

  }

  String? resetCode;
  verfiyResetPasswordRequest copyWith({
    String? resetCode,
  }) => verfiyResetPasswordRequest(
    resetCode: resetCode ?? this.resetCode,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resetCode'] = resetCode;
    return map;
  }

}