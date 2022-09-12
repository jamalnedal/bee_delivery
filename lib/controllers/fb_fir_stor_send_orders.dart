import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orders.dart';
import '/models/send_companies.dart';
import '/pref/shared_pref_controller.dart';

class FbFirestoreControllerSendOrders {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateSendOrder({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('sendOrder')
        .add(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSendOrder({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('sendOrder')
        .doc(orders.id)
        .update(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSendOrderCompany(
      {required SendOrderCompany sendOrderCompany}) async {
    return await _firebaseFirestore
        .collection('sendOrder')
        .doc(sendOrderCompany.id)
        .update(sendOrderCompany.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteSendOrder({required String id}) async {
    return await _firebaseFirestore
        .collection('sendOrder')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readSendOrder() async* {
    yield* _firebaseFirestore.collection('sendOrder').snapshots();
  }

  //

  Stream<QuerySnapshot> readCustomReadyOrdersShopInformation() async* {
    yield* _firebaseFirestore
        .collection("sendOrder")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomCompanies() async* {
    yield* _firebaseFirestore
        .collection("sendOrder")
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
}
