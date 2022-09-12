import 'package:cloud_firestore/cloud_firestore.dart';
import '/pref/shared_pref_controller.dart';
import '../models/register_men.dart';

class FbFirestoreRegistrationMenController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateDeliveryMan({required DeliveryMan man}) async {
    return await _firebaseFirestore
        .collection('Men')
        .add(man.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateDeliveryMan({required DeliveryMan man}) async {
    return await _firebaseFirestore
        .collection('Men')
        .doc(man.id)
        .update(man.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteDeliveryMan({required String id}) async {
    return await _firebaseFirestore
        .collection('Men')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readDeliveryMan() async* {
    yield* _firebaseFirestore.collection('Men').snapshots();
  }

  // Stream<QuerySnapshot> readCustomerMenProfileInformation() async* {
  //   yield* _firebaseFirestore.collection("Men")
  //       .where("identificationNumber", isEqualTo: SharedPrefController().identificationNumberMan).snapshots();
  // }//لو بدك بروفايل المان ديلفري

  Stream<QuerySnapshot> readCustomerOrdersManDelivery() async* {
    yield* _firebaseFirestore
        .collection("sendOrderCompanies")
        .where("deliveryEmployeeName", isEqualTo: SharedPrefController().name)
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
//حذف الكلكشن بشكل كامل
// Future<bool> Delet() async {
//   return await _firbasfirstore.collection('ShopOwners').get().then((snapshot) {
//     for (DocumentSnapshot ds in snapshot.docs) {
//       ds.reference.delete();
//     }
//     return true;
//   }
//   ).catchError((onError) => false);

}
