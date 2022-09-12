import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';

class FbFirestoreControllerSendOrdersCompanies {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateSendOrder({required Orders sendOrderCompany}) async {
    return await _firebaseFirestore
        .collection('sendOrderCompanies')
        .add(sendOrderCompany.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSendOrder({required Orders sendOrderCompany}) async {
    return await _firebaseFirestore
        .collection('sendOrderCompanies')
        .doc(sendOrderCompany.id)
        .update(sendOrderCompany.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteSendOrder({required String id}) async {
    return await _firebaseFirestore
        .collection('sendOrderCompanies')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readSendOrder() async* {
    yield* _firebaseFirestore.collection('sendOrderCompanies').snapshots();
  }

  //

  Stream<QuerySnapshot> readCustomShopOutDeliveryInformation() async* {
    yield* _firebaseFirestore
        .collection("sendOrderCompanies")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomSendOrdersCompaniesInformation() async* {
    yield* _firebaseFirestore
        .collection("sendOrderCompanies")
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
}
