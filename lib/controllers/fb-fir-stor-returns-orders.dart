import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';

class FbFirestoreReturnsOrdersController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateReturnsOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('returnsOrders')
        .add(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateReturnsOrders({required Orders orders}) async {
    return await _firebaseFirestore
        .collection('returnsOrders')
        .doc(orders.id)
        .update(orders.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteReturnsOrders({required String id}) async {
    return await _firebaseFirestore
        .collection('returnsOrders')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readReturnsOrders() async* {
    yield* _firebaseFirestore.collection('returnsOrders').snapshots();
  }

  Stream<QuerySnapshot> readCustomerMenReturnedOrders() async* {
    yield* _firebaseFirestore
        .collection("returnsOrders")
        .where("deliveryEmployeeName", isEqualTo: SharedPrefController().name)
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomerShopReturnedOrders() async* {
    yield* _firebaseFirestore
        .collection("returnsOrders")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomerCompanyReturnedOrders() async* {
    yield* _firebaseFirestore
        .collection("returnsOrders")
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
//

// Stream<QuerySnapshot> readCustomSendOrdersInformation() async* {
//   yield* _firebaseFirestore.collection("returnsOrders")
//       .where("gmail", isEqualTo: SharedPrefController().gmailShop).snapshots();
// }
//
// Stream<QuerySnapshot> readCustomSendOrdersCompaniesInformation() async* {
//   yield* _firebaseFirestore.collection("returnsOrders")
//       .where("deliveryCompany", isEqualTo: SharedPrefController().companyName).snapshots();
// }

}
