class FireBaseUser {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? id;

  FireBaseUser( this.name,this.email,this.phone,this.address, this.id);

  Map<String, dynamic> toFireStore() {

    return {
      'id': id,  'email': email,
      'phone': phone, 'address': address,
      'name': name
    };
  }

  FireBaseUser.fromFireStore(Map<String, dynamic>? mp) {
    id=mp?['id'];
    email=mp?['email'];
    name=mp?['name'];
    phone=mp?['phone'];
    address=mp?['address'];

  }

}
