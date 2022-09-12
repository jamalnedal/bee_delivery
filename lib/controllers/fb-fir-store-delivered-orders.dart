import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';

class FbFirestoreDeliveredOrdersController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateDeliveredOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('deliveredOrders')
        .add(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateDeliveredOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('deliveredOrders')
        .doc(orders.id)
        .update(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteDeliveredOrders({required String id}) async {
    return await _firebaseFirestore
        .collection('deliveredOrders')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readDeliveredOrders() async* {
    yield* _firebaseFirestore.collection('deliveredOrders').snapshots();
  }

  Stream<QuerySnapshot> readCustomerMenDeliveredOrders() async* {
    yield* _firebaseFirestore
        .collection("deliveredOrders")
        .where("deliveryEmployeeName", isEqualTo: SharedPrefController().name)
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomerShopDeliveredOrders() async* {
    yield* _firebaseFirestore
        .collection("deliveredOrders")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomerCompanyDeliveredOrders() async* {
    yield* _firebaseFirestore
        .collection("deliveredOrders")
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
//

// Stream<QuerySnapshot> readCustomSendOrdersInformation() async* {
//   yield* _firebaseFirestore.collection("deliveredOrders")
//       .where("gmail", isEqualTo: SharedPrefController().gmailShop).snapshots();
// }
//
// Stream<QuerySnapshot> readCustomSendOrdersCompaniesInformation() async* {
//   yield* _firebaseFirestore.collection("deliveredOrders")
//       .where("deliveryCompany", isEqualTo: SharedPrefController().companyName).snapshots();
// }

}
