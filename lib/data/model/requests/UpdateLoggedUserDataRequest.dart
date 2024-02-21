/// name : "lol"
/// email : "ahmedmutticc1@gmail.com"
/// phone : "01010700700"

class UpdateLoggedUserDataRequest {
  UpdateLoggedUserDataRequest({
      this.name, 
      this.email, 
      this.phone,});

  UpdateLoggedUserDataRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
  String? name;
  String? email;
  String? phone;
UpdateLoggedUserDataRequest copyWith({  String? name,
  String? email,
  String? phone,
}) => UpdateLoggedUserDataRequest(  name: name ?? this.name,
  email: email ?? this.email,
  phone: phone ?? this.phone,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}