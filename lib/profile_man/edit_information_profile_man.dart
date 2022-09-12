// import 'package:flutter/material.dart';
// import 'package:hope/controllers/fb-fir-stor-man-delivery.dart';
// import 'package:hope/controllers/fb_fir_store_companies.dart';
// import 'package:hope/models/preNumber.dart';
// import 'package:hope/models/registar_shop_owners.dart';
// import 'package:hope/models/register_companies.dart';
// import 'package:hope/screens/basic/helper.dart';
//
// import '../../controllers/fb-fir-stor-shop_owners.dart';
// import '../../controllers/fb_auth_controllers.dart';
// import '../../models/city.dart';
// import '../../pref/shared_pref_controller.dart';
// import '../models/register_men.dart';
//
// class EditInformationProfileMan extends StatefulWidget {
//   const EditInformationProfileMan({Key? key, this.man}) : super(key: key);
//   final Men? man;
//   @override
//   State<EditInformationProfileMan> createState() =>
//       _EditInformationProfileManState();
// }
//
// class _EditInformationProfileManState extends State<EditInformationProfileMan>
//     with Helper {
//   late TextEditingController _firstNameController;
//   late TextEditingController _identificationNumberController;
//   String? _emailError;
//   String? _passwordError;
//   String? _firstError;
//   String? _lastError;
//   String? _descriptionError;
//   String? _confirmPasswordError;
//   String? _storeNameError;
//   String? _mobileError;
//   String? _cityError;
//
//   @override
//   void initState() {
//     super.initState();
//     _firstNameController =
//         TextEditingController(text: widget.man?.firstName ?? '');
//     _identificationNumberController =
//         TextEditingController(text: widget.man?.identificationNumber ?? '');
//   }
//
//   @override
//   void dispose() {
//     _identificationNumberController.dispose();
//     _firstNameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             //TODO: go to previous page in a correct way
//             onPressed: () => Navigator.pop(context),
//             color: Colors.black,
//           ),
//
//           //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
//           title: const Text(
//             'تعديل الحساب',
//             style: TextStyle(
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black),
//           ),
//           //عنوان الاب بار
//           centerTitle: true,
//           // سنترنا العنوان
//           backgroundColor: const Color(0xffffcc33),
//
//           // لون خلفيه الاب بار
//           //shadowColor: Colors.black,
//           // لحتى يتواجد ظل اسود تحت الاب بار
//           elevation: 0, // درجة الظل
//         ),
//         body: Container(
//           padding: const EdgeInsets.only(right: 40, left: 40, top: 10),
//           color: Colors.grey.shade100,
//           alignment: Alignment.center,
//           height: double.infinity,
//           child: Column(children: [
//             ListView(shrinkWrap: true, children: [
//               TextField(
//                 style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//                 controller: _identificationNumberController,
//                 decoration: InputDecoration(
//                   errorText: _firstError,
//                   label: Text(
//                     'رقم الهوية ',
//                     style:
//                         TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.text_format,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                   errorText: _lastError,
//                   label: Text(
//                     'الاسم ',
//                     style:
//                         TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.text_format,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 // color: Colors.yellow.shade500,
//                 height: 40.0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black, width: 1),
//                   color: const Color(0xffffcc33),
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 //margin : const EdgeInsets.only(left: 50),
//                 child: MaterialButton(
//                   //زر لتاكيد تسجيل الدخول
//
//                   onPressed: () async {
//                     _UpdateProfile();
//                     //await perfoemLogin();
//                     //await prosess();
//                     // await delet();
//                   },
//
//                   child: const Text(
//                     ' تعديل الحساب',
//                     style: TextStyle(
//                         fontFamily: 'Tajawal',
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ]),
//           ]),
//         ));
//   }
//
//   Future<void> perfoemLogin() async {
//     if (chekdata()) {
//       await _UpdateProfile();
//     }
//   }
//
//   bool chekdata() {
//     if (_identificationNumberController.text.isNotEmpty &&
//         _firstNameController.text.isNotEmpty) {
//       controlError();
//       return true;
//     } else {
//       controlError();
//       showSnackBarMessage();
//       return false;
//     }
//   }
//
//   void controlError() {
//     // setState(() {
//     //   _emailError =
//     //   _emailController.text.isEmpty ? 'ادخل الايميل' : null;
//     //   _firstError =
//     //   _fi.text.isEmpty ? 'ادخل الاسم الاول' : null;
//     //   _lastError =
//     //   _lastNameController.text.isEmpty ? 'ادخل الاسم الاخير' : null;
//     //   _storeNameError =
//     //   _storeNameController.text.isEmpty ? 'ادخل اسم المتجر' : null;
//     //   _descriptionError =
//     //   _descriptionController.text.isEmpty ? 'ادخل الوصف' : null;
//     //   _confirmPasswordError =
//     //   _confirmPasswordController.text.isEmpty ? 'ادخل تاكيد كلمة المرور' : null;
//     //   _mobileError =
//     //   _mobileController.text.isEmpty ? 'ادخل الموبايل' : null;
//     //
//     // });
//   }
//
//   void showSnackBarMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text('خطأ في المعلومات المُدخلة'),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//         onVisible: () => print('Visible'),
//         //to know that the error showed
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         action: SnackBarAction(
//             label: 'تخطي', textColor: Colors.white, onPressed: () {})));
//   }
//
//   // bool checkPassword(){
//   //   bool statuse=_passwordController.text==_confirmPasswordController.text;
//   //   if(statuse){
//   //     return true;
//   //   }else{
//   //     showsnakbar(
//   //       Context: context,
//   //       massage: 'The password confirmation does not match the password',
//   //       error: !statuse,
//   //     );
//   //     return false;
//   //   }
//   // }
//   // bool checkMobile(){
//   //   bool statusStart=_mobileController.text[0]+_mobileController.text[1]=='59';
//   //   bool statuNumberOfLetters=_mobileController.text.length<9;
//   //   bool status=_mobileController.text[0]+_mobileController.text[1]=='59'&&_mobileController.text.length==9;
//   //   print(status);
//   //   if(status){
//   //     return true;
//   //   }else {
//   //     if (statusStart == false) {
//   //       showsnakbar(
//   //         Context: context,
//   //         massage: 'رقم الهاتف يجب ان يبدا ب 59 ',
//   //         error: !status,
//   //       );
//   //       return false;
//   //     } else {
//   //       showsnakbar(
//   //         Context: context,
//   //         massage: 'يجب ان يكون اكبر من تسعة',
//   //         error: !status,
//   //       );
//   //       return false;
//   //     }
//   //   }
//   // }
//
//   Future<void> _UpdateProfile() async {
//     bool status =
//         await FbFirestoreRegistrationMenController().updateMen(men: man);
//     if (status) {
//       showsnakbar(Context: context, massage: 'updated');
//     }
//   }
//
//   // Future<void> prosess() async {
//   //   bool statuse = await FbFirstorecontrooler().crate(shopOwners:shopOwners);
//   //   if(statuse){
//   //     SharedPrefController().save(shopOwners: shopOwners);
//   //     showsnakbar(
//   //       Context: context,
//   //       massage: statuse ? 'Process success' : 'Process failed',
//   //       error: !statuse,
//   //     );
//   //   }
//
//   // } Future<void> delet() async {
//   //   bool statuse = await FbFirstorecontrooler().Delet();
//   //   if(statuse){
//   //     SharedPrefController().save(shopOwners: shopOwners);
//   //     showsnakbar(
//   //       Context: context,
//   //       massage: statuse ? 'Process success' : 'Process failed',
//   //       error: !statuse,
//   //     );
//   //   }
//   //
//   // }
//   Men get man {
//     Men man = Men();
//     man.id = widget.man!.id;
//     man.firstName = _firstNameController.text;
//     man.identificationNumber = _identificationNumberController.text;
//     man.companyName = widget.man!.companyName;
//     man.password = widget.man!.password;
//     return man;
//   }
// }
