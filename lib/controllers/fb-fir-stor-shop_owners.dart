import 'package:cloud_firestore/cloud_firestore.dart';
import '/pref/shared_pref_controller.dart';
import '../models/registar_shop_owners.dart';

class FbFirestoreRegistrationShopOwnersController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crateShopOwners({required ShopOwners shopOwners}) async {
    return await _firebaseFirestore
        .collection('ShopOwners')
        .add(shopOwners.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateShopOwners({required ShopOwners shopOwners}) async {
    return await _firebaseFirestore
        .collection('ShopOwners')
        .doc(shopOwners.id)
        .update(shopOwners.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteShopOwners({required String id}) async {
    return await _firebaseFirestore
        .collection('ShopOwners')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readShopOwners() async* {
    yield* _firebaseFirestore.collection('ShopOwners').snapshots();
  }

  Stream<QuerySnapshot> readCustomerShopOwnersProfileInformation() async* {
    yield* _firebaseFirestore
        .collection("ShopOwners")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop)
        .snapshots();
  }
//كود للمعرفة
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
