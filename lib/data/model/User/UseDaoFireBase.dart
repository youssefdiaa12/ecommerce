import 'package:cloud_firestore/cloud_firestore.dart';

import 'FireBaseUser.dart';

class UserDaoFireBase {

  static CollectionReference<FireBaseUser> getusercollection(){
    var db = FirebaseFirestore.instance;
    var dbDoc = db.collection('user').withConverter<FireBaseUser>(
      fromFirestore: (snapshot, options) => FireBaseUser.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
    return dbDoc;
  }

  static Future<void> createuser(FireBaseUser user) {
    var dbDoc=getusercollection();
    return dbDoc.doc(user.id).set(user);

  }
  static Future<void>Deleteuser(FireBaseUser user) {
    var dbDoc=getusercollection();
    return dbDoc.doc(user.id).delete();
  }
  static Future<FireBaseUser?> getuser( String ?id)async{
    var doc1=getusercollection();
    var docSnapShot =await  doc1.doc(id).get();
    return docSnapShot.data();
  }
  static Future<void> updateuser(FireBaseUser user) {
    var dbDoc = getusercollection();
    return dbDoc.doc(user.id).update(user.toFireStore());
  }
}