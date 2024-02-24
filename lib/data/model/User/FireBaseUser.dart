class FireBaseUser {
  String? email;
  String? id;

  FireBaseUser( this.email, this.id);

  Map<String, dynamic> toFireStore() {

    return {
      'id': id,  'email': email,
    };
  }

  FireBaseUser.fromFireStore(Map<String, dynamic>? mp) {
    id=mp?['id'];
    email=mp?['email'];
  }

}
