import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/registar_shop_owners.dart';
import '../controllers/fb-fir-stor-shop_owners.dart';
import '../controllers/fb_auth_controllers.dart';
import '../screens/basic/helper.dart';
import 'edit_information_profile_shop.dart';

class EditProfileShop extends StatefulWidget {
  const EditProfileShop({Key? key}) : super(key: key);

  @override
  State<EditProfileShop> createState() => _EditProfileShopState();
}

class _EditProfileShopState extends State<EditProfileShop> with Helper {
  late TextEditingController _passwordController;
  late TextEditingController _passwordNewController;
  late TextEditingController _passwordConfirmController;
  late QueryDocumentSnapshot documentSnapshot;
  bool obscureTextPassword = true;
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
  bool? determineTheInternetConnection; //تحديد اتصال الانترنت
  String? password;
  String? passwordNewError;
  String? passwordConfirmError;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordNewController = TextEditingController();
    _passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordNewController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),

          //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
          title: const Text(
            'تعديل البروفايل',
            style: TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          //عنوان الاب بار
          centerTitle: true,
          // سنترنا العنوان
          backgroundColor: const Color(0xffffcc33),

          // لون خلفيه الاب بار
          //shadowColor: Colors.black,
          // لحتى يتواجد ظل اسود تحت الاب بار
          elevation: 0, // درجة الظل
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            // height: double.infinity,
            child: ListView(shrinkWrap: true, children: [
              Column(children: [
                Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2018/01/29/17/01/woman-3116587_960_720.jpg'),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text(
                      'تعديل معلومات الحساب',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    StreamBuilder<QuerySnapshot>(
                        stream: FbFirestoreRegistrationShopOwnersController()
                            .readCustomerShopOwnersProfileInformation(),
                        //كود استدعاء بيانات الشخصية للعميل الواحد في المتجر
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(),
                            );
                          } else {
                            List<QueryDocumentSnapshot>
                                documentShopOwnersProfile = snapshot.data!.docs;
                            documentSnapshot = documentShopOwnersProfile[0];
                            return IconButton(
                              icon: const Icon(Icons.mode_edit_outline),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditInformationProfileShop(
                                      shopOwners: shopOwnersInformation(
                                          documentShopOwnersProfile[0], false),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: const [
                  Expanded(child: Divider(color: Colors.black)),
                  Text(
                    'تغير كلمة المرور',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Expanded(child: Divider(color: Colors.black))
                ]),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordController,
                  obscureText: obscureTextPassword,
                  decoration: InputDecoration(
                    errorText: password,
                    label: const Text(
                      'كلمة المرور القديمة ',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                    ),
                    prefixIcon: const Icon(
                      Icons.text_format,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextPassword = !obscureTextPassword;
                        });
                      },
                      icon: Icon(
                          obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xffffcc33)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordNewController,
                  obscureText: obscureTextNewPassword,
                  decoration: InputDecoration(
                    errorText: passwordNewError,
                    label: const Text(
                      'كلمة المرور الجديدة',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                    ),
                    prefixIcon: const Icon(
                      Icons.text_format,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextNewPassword = !obscureTextNewPassword;
                        });
                      },
                      icon: Icon(
                          obscureTextNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xffffcc33)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordConfirmController,
                  obscureText: obscureTextConfirmPassword,
                  decoration: InputDecoration(
                    errorText: passwordConfirmError,
                    label: const Text(
                      'تأكيد كلمة المرور الجديدة ',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                    ),
                    prefixIcon: const Icon(
                      Icons.text_format,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextConfirmPassword =
                              !obscureTextConfirmPassword;
                        });
                      },
                      icon: Icon(
                          obscureTextConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xffffcc33)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  // color: Colors.yellow.shade500,
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: const Color(0xffffcc33),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //margin : const EdgeInsets.only(left: 50),
                  child: MaterialButton(
                    //زر لتاكيد تسجيل الدخول

                    onPressed: () async {
                      await initConnectivity();
                      if (determineTheInternetConnection == false) {
                        showsnakbar(
                            Context: context,
                            massage: 'غير متصل بالانترنت حاليا',
                            error: true);
                      } else if (determineTheInternetConnection == true) {
                        await performRegister();
                      }
                    },
                    child: const Text(
                      'تعديل كلمة المرور',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ]),
            ])));
  }

  Future<void> performRegister() async {
    if (checkData() && checkPassword()) {
      bool changePassword = await changePasswordShop();
      if (changePassword == true) {
        shopOwnersInformation(documentSnapshot, true);
        clear();
      }
    }
  }

  bool checkData() {
    if (_passwordController.text.isNotEmpty &&
        _passwordNewController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty) {
      controlError();
      return true;
    } else {
      controlError();
      showSnackBarMessage();
      return false;
    }
  }

  void controlError() {
    setState(() {
      password = _passwordController.text.isEmpty ? 'ادخل كلمة السر' : null;
      passwordNewError =
          _passwordNewController.text.isEmpty ? 'ادخل كلمة السر الجديدة' : null;
      passwordConfirmError = _passwordConfirmController.text.isEmpty
          ? 'ادخل تاكيد كلمة السر'
          : null;
    });
  }

  void showSnackBarMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('خطأ في المعلومات المُدخلة'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        onVisible: () => print('Visible'),
        //to know that the error showed
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
            label: 'تخطي', textColor: Colors.white, onPressed: () {})));
  }

  ShopOwners shopOwnersInformation(documentSnapshot, caseEdit) {
    //لانه يتم طلب التعديل في الميثود المسوؤلة عن جمع المعلومات فعند استدعائها ستنفذ عملية التعديل ايضا وهذا خطاCaseEdit
    bool password = _passwordNewController.text == '';
    ShopOwners shopOwners = ShopOwners();
    shopOwners.id = documentSnapshot.id;
    shopOwners.firstName = documentSnapshot.get('firstName');
    shopOwners.lastName = documentSnapshot.get('lastName');
    shopOwners.storeName = documentSnapshot.get('storeName');
    shopOwners.city = documentSnapshot.get('city');
    shopOwners.mobile = documentSnapshot.get('mobile');
    shopOwners.description = documentSnapshot.get('description');
    shopOwners.gmail = documentSnapshot.get('gmail');
    shopOwners.password =
        password //اما ان تذهب بكلمة السر القديمة او اذا اردت التعديل تذهب بالجديدة لتعديل باقي البيانات
            ? documentSnapshot.get('password')
            : _passwordNewController.text;
    if (caseEdit) {
      updateProfile(shopOwners);
    }
    return shopOwners;
  }

  bool checkPassword() {
    bool statusLengthen = _passwordNewController.text.length >= 6;
    bool statusEqual =
        _passwordNewController.text == _passwordConfirmController.text;
    bool checkPassword = statusLengthen && statusEqual;
    if (checkPassword) {
      return true;
    } else if (!statusLengthen) {
      showsnakbar(
        Context: context,
        massage: 'كلمة المرور يجب ان تكون اكبر من او تساوي ست حروف او ارقام'
            '',
        error: true,
      );
      return false;
    } else if (!statusEqual) {
      showsnakbar(
        Context: context,
        massage: 'كلمة المرور الجديدة لا تتطابق مع تأكيد كلمة مرور ',
        error: true,
      );
      return false;
    }
    return false;
  }

  Future<bool> changePasswordShop() async {
    return await FbAuthControllers().changePassword(
        _passwordController.text, _passwordNewController.text, context);
  }

  Future<void> updateProfile(ShopOwners shopOwners) async {
    bool status = await FbFirestoreRegistrationShopOwnersController()
        .updateShopOwners(shopOwners: shopOwners);
    if (status) {
      showsnakbar(Context: context, massage: 'updated');
    }
  }

  Future<void> initConnectivity() async {
    ///////////////////////////////////دوال فحص الاتصال بالانترنت
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    if (result == ConnectivityResult.none) {
      return updateConnectionState(result);
    } else if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return updateConnectionState(result);
    }
  }

  Future<void> updateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      determineTheInternetConnection = status;
    } else {
      determineTheInternetConnection = status;
    }
  }

  void clear() {
    _passwordController.text = '';
    _passwordNewController.text = '';
    _passwordConfirmController.text = '';
  }
}
