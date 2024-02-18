/// name : "dada"
/// email : "dada12@gmail.com"
/// password : "dada123"
/// rePassword : "dada123"
/// phone : "01010700701"

class RegisterationRequest {
  RegisterationRequest({
      this.name, 
      this.email, 
      this.password, 
      this.rePassword, 
      this.phone,});

  RegisterationRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    phone = json['phone'];
  }
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? phone;
RegisterationRequest copyWith({  String? name,
  String? email,
  String? password,
  String? rePassword,
  String? phone,
}) => RegisterationRequest(  name: name ?? this.name,
  email: email ?? this.email,
  password: password ?? this.password,
  rePassword: rePassword ?? this.rePassword,
  phone: phone ?? this.phone,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['phone'] = phone;
    return map;
  }

}