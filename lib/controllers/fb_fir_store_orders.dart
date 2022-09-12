import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';

class FbFirestoreControllerOrders {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('Orders')
        .add(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('Orders')
        .doc(orders.id)
        .update(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteOrders({required String id}) async {
    return await _firebaseFirestore
        .collection('Orders')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readOrders() async* {
    yield* _firebaseFirestore.collection('Orders').snapshots();
  }

  //

  Stream<QuerySnapshot> readCustomShopOrdersInformation() async* {
    yield* _firebaseFirestore
        .collection("Orders")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }
}
