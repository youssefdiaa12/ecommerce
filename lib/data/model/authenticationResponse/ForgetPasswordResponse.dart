/// statusMsg : "success"
/// message : "Reset code sent to your email"

class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.statusMsg, 
      this.message,});

  ForgetPasswordResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }
  String? statusMsg;
  String? message;
ForgetPasswordResponse copyWith({  String? statusMsg,
  String? message,
}) => ForgetPasswordResponse(  statusMsg: statusMsg ?? this.statusMsg,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }

}