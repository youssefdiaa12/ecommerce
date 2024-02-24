import 'package:cloud_firestore/cloud_firestore.dart';

import 'UseDaoFireBase.dart';
import 'UserCartList.dart';


class CartListDao {
  static CollectionReference<UserCartList> getCartListCollection(String id) {
    var db = UserDaoFireBase
        .getusercollection()
        .doc(id)
        .collection('cartList')
        .withConverter(
        fromFirestore: (snapshot, options) =>
            UserCartList.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore());

    return db;
  }

  static Future<void> createTask(UserCartList taskia, String? id) async {
    var dbRef = getCartListCollection(id!).doc(taskia.productId);
    await dbRef.set(taskia);
  }

  static Future<List<UserCartList>> getTasks(String id) async {
    var dbRef = await getCartListCollection(id).get();
    var taskList = dbRef.docs.map((snapshot) => snapshot.data()).toList();
    return taskList;
  }

  static Future<void> deleteTask(UserCartList? taskia, String? id) async {
    await getCartListCollection(id!).doc(taskia?.productId).delete();
  }

  static Future<bool>is_found_task(UserCartList? taskia, String? id) async {
    var dbRef = await getCartListCollection(id!).doc(taskia?.productId).get();
    return dbRef.exists;
  }
  static Future<void> editTask(UserCartList? cartistObj, String? id) async {
    await getCartListCollection(id!).doc(cartistObj?.productId).update({
      'productId': cartistObj?.productId,
      'quantity': cartistObj?.quantity
    });
  }

  // static Stream<List<UserCartList>> listForTasks(String id, DateTime obj) async* {
  //
  //   var start = DateTime(obj.year, obj.month, obj.day);
  //   var end = DateTime(obj.year, obj.month, obj.day, 23, 59, 59);
  //
  //   var data = gettaskcollection(id)
  //       .where('time', isGreaterThanOrEqualTo: start)
  //       .where('time', isLessThanOrEqualTo: end)
  //       .snapshots();
  //
  //   yield* data.map((snapshot) =>
  //       snapshot.docs.map((snapshot) => snapshot.data()).toList());
  // }
}
