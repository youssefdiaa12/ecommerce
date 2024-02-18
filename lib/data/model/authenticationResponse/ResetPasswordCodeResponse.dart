/// status : "Success"

class ResetPasswordCodeResponse {
  ResetPasswordCodeResponse({
      this.status,});

  ResetPasswordCodeResponse.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;
ResetPasswordCodeResponse copyWith({  String? status,
}) => ResetPasswordCodeResponse(  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}