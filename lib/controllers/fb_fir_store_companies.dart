import 'package:cloud_firestore/cloud_firestore.dart';
import '/pref/shared_pref_controller.dart';
import '../models/register_companies.dart';

class FbFirestoreControllerCompanies {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> crate({required Companies companies}) async {
    return await _firebaseFirestore
        .collection('Companies')
        .add(companies.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> Update({required Companies companies}) async {
    return await _firebaseFirestore
        .collection('Companies')
        .doc(companies.id)
        .update(companies.toMAp())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> Delete({required String id}) async {
    return await _firebaseFirestore
        .collection('Companies')
        .doc(id.toString())
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readCompanies() async* {
    yield* _firebaseFirestore.collection('Companies').snapshots();
  }

  //

  Stream<QuerySnapshot> readCustomerProfileInformation() async* {
    yield* _firebaseFirestore
        .collection("Companies")
        .where("gmail", isEqualTo: SharedPrefController().gmailCom)
        .snapshots();
  }

  Stream<QuerySnapshot> readCustomerMenDelivery() async* {
    yield* _firebaseFirestore
        .collection("Men")
        .where("companyName", isEqualTo: SharedPrefController().companyName)
        .snapshots();
  }
}
