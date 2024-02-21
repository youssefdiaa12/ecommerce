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
      this.phone,
    this.address,
    this.pass,
  });

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    token = json['token'];
    phone = json['phone'];
    address = json['address'];
    pass = json['pass'];
  }
  String? name;
  String? email;
  String? role;
  String? token;
  String?phone;
  String? address;
  String? pass;
User copyWith({  String? name,
  String? email,
  String? role,
  String? token,
  String? phone,
  String? address,
  String? pass,
}) => User(  name: name ?? this.name,
  email: email ?? this.email,
  role: role ?? this.role,
  token: token ?? this.token,
  phone: phone ?? this.phone,
  address: address ?? this.address,
  pass: pass ?? this.pass,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['token'] = token;
    map['phone'] = phone;
    map['address'] = address;
    map['pass'] = pass;
    return map;
  }


}