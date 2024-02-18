/// name : "dada"
/// email : "dada12@gmail.com"
/// role : "user"
/// token : ""

class User {
  User({
      this.name, 
      this.email, 
      this.role, 
      this.token,
      this.phone,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    token = json['token'];
  }
  String? name;
  String? email;
  String? role;
  String? token;
  String?phone;
User copyWith({  String? name,
  String? email,
  String? role,
  String? token,
}) => User(  name: name ?? this.name,
  email: email ?? this.email,
  role: role ?? this.role,
  token: token ?? this.token,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['token'] = token;
    return map;
  }


}