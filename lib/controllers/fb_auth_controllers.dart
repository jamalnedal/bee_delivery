import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '/pref/shared_pref_controller.dart';
import '../screens/basic/helper.dart';

typedef UserStateCalback = void Function(bool status);

class FbAuthControllers with Helper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> createAccount(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        showsnakbar(Context: context, massage: 'تم انشاء الحساب بنجاح');
        await userCredential.user!.sendEmailVerification();
        await signOut();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      controllerAuthException(context: context, exception: e);
    } catch (e) {}
    return false;
  }

  Future<bool> login(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return true;
        }
        showsnakbar(
            Context: context,
            massage: 'رفض تسجيل الدخول ، أرسل بريدك الإلكتروني',
            error: true);
        userCredential.user!.emailVerified;
        await signOut();
      }
      return false;
    } on FirebaseAuthException catch (e) {
      controllerAuthException(exception: e, context: context);
    } catch (e) {}
    return false;
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      controllerAuthException(exception: e, context: context);
    } catch (e) {}
    return false;
  }

  void controllerAuthException(
      {required FirebaseAuthException exception,
      required BuildContext context}) {
    showsnakbar(
        Context: context, massage: exception.message ?? '', error: true);
    if (exception.code == 'email-already-in-use') {}
    if (exception.code == 'invalid-email') {}
    if (exception.code == 'operation-not-allowed') {}
    if (exception.code == 'weak-password') {}
    if (exception.code == 'user-disabled') {}
    if (exception.code == 'user-not-found') {}
    if (exception.code == 'wrong-password') {}
  }

  StreamSubscription listenToUserState(
      {required UserStateCalback userStateCalback}) {
    return _firebaseAuth.authStateChanges().listen((user) {
      userStateCalback(user != null);
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    bool? isChanged = true;
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: SharedPrefController().gmailShop, password: currentPassword);
    try {
      await user!.reauthenticateWithCredential(cred).then((value) {
        user
            .updatePassword(newPassword)
            .then((_) => isChanged = true)
            .catchError((error) {});
      }).catchError((error) {
        isChanged = false;
        showsnakbar(Context: context, massage: error.toString(), error: true);
      });
    } on FirebaseAuthException catch (e) {
      controllerAuthException(exception: e, context: context);
    } catch (e) {}
    return isChanged!;
  }
}
