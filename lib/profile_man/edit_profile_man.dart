// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hope/controllers/fb-fir-stor-man-delivery.dart';
// import 'package:hope/controllers/fb_fir_store_companies.dart';
// import 'package:hope/models/registar_shop_owners.dart';
// import 'package:hope/models/register_companies.dart';
// import 'package:hope/pref/shared_pref_controller.dart';
// import 'package:hope/profile_man/edit_information_profile_man.dart';
// import '../controllers/fb-fir-stor-shop_owners.dart';
// import '../controllers/fb_auth_controllers.dart';
// import '../models/register_men.dart';
// import '../screens/basic/helper.dart';
//
// class EditProfileMan extends StatefulWidget {
//   const EditProfileMan({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfileMan> createState() => _EditProfileManState();
// }
//
// class _EditProfileManState extends State<EditProfileMan> with Helper {
//   late TextEditingController _passwordController;
//   late TextEditingController _passwodrnewdController;
//   late TextEditingController _passwordconfirmController;
//   late QueryDocumentSnapshot documentSnapshot;
//   bool caseEdite=false;
//
//   @override
//   void initState() {
//     super.initState();
//     _passwordController = TextEditingController();
//     _passwodrnewdController = TextEditingController();
//     _passwordconfirmController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _passwodrnewdController.dispose();
//     _passwordconfirmController.dispose();
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
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               }),
//
//           //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
//           title: Text(
//             'تعديل البروفايل',
//             style: const TextStyle(
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
//             padding: const EdgeInsets.only(left: 40, right: 40,bottom: 50),
//             color: Colors.grey.shade100,
//             alignment: Alignment.center,
//             height: double.infinity,
//             child: ListView(shrinkWrap: true, children: [
//               Column(children: [
//                 Container(
//                     width: 130,
//                     height: 130,
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 4, color: Colors.white),
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             color: Colors.black.withOpacity(0.1))
//                       ],
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(
//                               'https://media.istockphoto.com/photos/handsome-young-man-picture-id618033536?k=20&m=618033536&s=612x612&w=0&h=krAiFm5Q3bcDXZ0EkiF1CWnWG28Fpc2JI2hT-_B3Umk=')
//                       ),
//                     )),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                       mainAxisSize: MainAxisSize.min, children: [
//                     Text('تعديل معلومات الحساب',
//                       style:TextStyle(
//                           fontFamily: 'Tajawal',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black),),
//                     SizedBox(width: 5),
//                     StreamBuilder<QuerySnapshot>(
//                         stream: FbFirestoreRegistrationMenController().readCustomerMenProfileInformation(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Transform.scale(
//                               scale: 0.5,
//                               child: CircularProgressIndicator(),
//                             );
//                           } else {
//                             List<QueryDocumentSnapshot> _document =
//                                 snapshot.data!.docs;
//                             documentSnapshot=_document[0];
//                             return
//                               IconButton(icon: Icon(
//                                   Icons.mode_edit_outline),onPressed:(){
//                                  Navigator.push(context, MaterialPageRoute(builder: (
//                                     context) => EditInformationProfileMan(man:man(documentSnapshot, false),)));
//                               },);
//                           }
//                         }),
//
//
//                   ]),
//
//
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children:[
//                       Expanded(child: Divider(color: Colors.black)),
//                       Text('تغير كلمة المرور',style:TextStyle(
//                           fontFamily: 'Tajawal',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black),),
//                       Expanded(child:Divider(color: Colors.black))
//                     ]),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   style:  TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Tajawal'),
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     label: const Text(
//                       'كلمة المرور القديمة ',
//                       style: const TextStyle(
//                           color: Colors.black, fontFamily: 'Tajawal'),
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.text_format,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   style:  TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Tajawal'),
//                   controller: _passwodrnewdController,
//                   decoration: InputDecoration(
//                     label: const Text(
//                       'كلمة المرور الجديدة',
//                       style: const TextStyle(
//                           color: Colors.black, fontFamily: 'Tajawal'),
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.text_format,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   style:  TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Tajawal'),
//                   controller: _passwordconfirmController,
//                   decoration: InputDecoration(
//                     label: const Text(
//                       'تأكيد كلمة المرور الجديدة ',
//                       style: const TextStyle(
//                           color: Colors.black, fontFamily: 'Tajawal'),
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.text_format,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   // color: Colors.yellow.shade500,
//                   height: 40.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 1),
//                     color: const Color(0xffffcc33),
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   //margin : const EdgeInsets.only(left: 50),
//                   child: MaterialButton(
//                     //زر لتاكيد تسجيل الدخول
//
//                     onPressed: () async {
//                       await performRegister();
//                     },
//                     // await _register();
//                     // await perfoemLogin();
//                     //await prosess();
//                     //await delet();
//
//                     child: Text(
//                       'تعديل كلمة المرور',
//                       style: TextStyle(
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//
//               ]),
//             ])));
//
//     // Container(
//     //   // color: Colors.yellow.shade500,
//     //   height: 40.0,
//     //   width: double.infinity,
//     //   decoration: BoxDecoration(
//     //     border: Border.all(color: Colors.black, width: 1),
//     //     color: const Color(0xffffcc33),
//     //     shape: BoxShape.rectangle,
//     //     borderRadius: BorderRadius.circular(10),
//     //   ),
//     //   //margin : const EdgeInsets.only(left: 50),
//     //   child: MaterialButton(
//     //     //زر لتاكيد تسجيل الدخول
//     //
//     //     onPressed: () {
//     //       _login();
//     //       setState(() {});
//     //       // await _register();
//     //       // await perfoemLogin();
//     //       //await prosess();
//     //       //await delet();
//     //     },
//     //
//     //     child: const Text(
//     //       ' إنشاء طلب',
//     //       style: TextStyle(
//     //           fontFamily: 'Tajawal',
//     //           fontWeight: FontWeight.w700,
//     //           color: Colors.black),
//     //     ),
//     //   ),
//     // ),
//
//   }
//   Future<void> performRegister() async {
//     if (checkPassword()) {
//       await SharedPrefController().saveLoginMan(identificationNumberMan: SharedPrefController().identificationNumberMan, password: _passwodrnewdController.text, companyName: SharedPrefController().companyName, name: SharedPrefController().name);
//       man(documentSnapshot,true);}
//   }
//
//   Men man(documentSnapshot,caseEdite) {
//     bool password=_passwodrnewdController.text=='';
//     Men man = Men();
//     man.id = documentSnapshot.id;
//     man.identificationNumber = documentSnapshot.get('identificationNumber');
//     man.companyName = documentSnapshot.get('companyName');
//     man.firstName = documentSnapshot.get('firstName');
//     man.password =password?documentSnapshot.get('password'):_passwodrnewdController.text;
//     if(caseEdite) {
//       _UpdateProfile(man);
//     }
//     return man;
//   }
//   bool checkPassword(){
//     bool agree=_passwodrnewdController.text==_passwordconfirmController.text;
//     bool isFound= _passwordController.text==SharedPrefController().passwordMan;
//     bool isGreater=_passwodrnewdController.text.length>=6;
//     bool changeExists=_passwordController.text.length!=_passwodrnewdController.text.length;
//     print(changeExists);
//     bool status=agree&&isFound&&isGreater&&changeExists;
//     if(status){
//       return true;
//     }else {
//       if (!agree) {
//         showsnakbar(
//           Context: context,
//           massage: 'كلمة المرور الجديدة لا تتطابق مع تأكيد كلمة مرور ',
//           error: !status,
//         );
//         return false;
//       } else if (!isFound) {
//         showsnakbar(
//           Context: context,
//           massage: 'كلمة المرور خاطئة',
//           error: !status,
//         );
//         return false;
//       }
//       else if (!isGreater) {
//         showsnakbar(
//           Context: context,
//           massage: 'يجب ان تكون كلمة المرو اكبر من او يساوي ست ارقام',
//           error: !status,
//         );
//         return false;
//       } else {
//         if (!changeExists) {
//           showsnakbar(
//             Context: context,
//             massage: 'يجب ان يكون التغير بكلمة جديدة',
//             error: !status,
//           );
//           return false;
//         }
//         return false;
//       }
//     }}
//
//
//   Future<void> _UpdateProfile(Men man) async {
//     bool status = await FbFirestoreRegistrationMenController().updateMen(men:man);
//     if(status){
//       showsnakbar(Context: context, massage: 'updated');
//     }}
//
// }
