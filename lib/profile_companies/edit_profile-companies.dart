import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb_fir_store_companies.dart';
import '/models/register_companies.dart';
import '../screens/basic/helper.dart';
import 'edit_information_profile_companies.dart';

class EditProfileCompany extends StatefulWidget {
  const EditProfileCompany({Key? key}) : super(key: key);

  @override
  State<EditProfileCompany> createState() => _EditProfileCompanyState();
}

class _EditProfileCompanyState extends State<EditProfileCompany> with Helper {
  late TextEditingController _passwordController;
  late TextEditingController _passwordNewController;
  late TextEditingController _passwordConfirmController;
  late QueryDocumentSnapshot documentSnapshot;
  bool? determineTheInternetConnection; //تحديد اتصال الانترنت
  bool obscureTextPassword = true;
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
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
            height: double.infinity,
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
                              'https://cdn.pixabay.com/photo/2017/04/01/21/06/portrait-2194457_960_720.jpg')),
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
                        stream: FbFirestoreControllerCompanies()
                            .readCustomerProfileInformation(),
                        //كود قراءة معلومات صاحب الشركة وتغير كلمة سره
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(),
                            );
                          } else {
                            List<QueryDocumentSnapshot>
                                documentCompanyProfileInformation =
                                snapshot.data!.docs;
                            documentSnapshot =
                                documentCompanyProfileInformation[0];
                            return IconButton(
                              icon: const Icon(Icons.mode_edit_outline),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditInformationProfileCompanies(
                                              companies:
                                                  companiesInformationProfile(
                                                      documentSnapshot, false),
                                            )));
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
                  obscureText: obscureTextPassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordController,
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
                  obscureText: obscureTextNewPassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordNewController,
                  decoration: InputDecoration(
                      errorText: passwordNewError,
                      label: const Text(
                        'كلمة المرور الجديدة',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
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
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: obscureTextConfirmPassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                      errorText: passwordConfirmError,
                      label: const Text(
                        'تأكيد كلمة المرور الجديدة ',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
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
                      )),
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
                        await performCompaniesInformationProfile();
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

  Future<void> performCompaniesInformationProfile() async {
    if (checkData() && checkPassword()) {
      companiesInformationProfile(documentSnapshot, true);
      clear();
    }
  }

  Companies companiesInformationProfile(documentSnapshot, caseEdit) {
    bool password = _passwordNewController.text == '';
    Companies companies = Companies();
    companies.id = documentSnapshot.id;
    companies.gmail = documentSnapshot.get('gmail');
    companies.companyName = documentSnapshot.get('companyName');
    companies.telephoneFix = documentSnapshot.get('telephoneFix');
    companies.city = documentSnapshot.get('city');
    companies.mobile = documentSnapshot.get('mobile');
    companies.description = documentSnapshot.get('description');
    companies.password = password
        ? documentSnapshot.get('password')
        : _passwordNewController.text;
    if (caseEdit) {
      updateProfile(companies);
    }
    return companies;
  }

  bool checkPassword() {
    bool agree = _passwordNewController.text == _passwordConfirmController.text;
    bool isFound = _passwordController.text ==
        documentSnapshot.get(
            'password'); //الحصول على كلمة السر من كل تغير يحصص مباشرة للفحص
    bool isGreater = _passwordNewController.text.length >= 6;
    bool status = agree && isFound && isGreater;
    if (status) {
      return true;
    } else {
      if (!isFound) {
        showsnakbar(
          Context: context,
          massage: 'كلمة المرور خاطئة',
          error: !status,
        );
        return false;
      } else if (!agree) {
        showsnakbar(
          Context: context,
          massage: 'كلمة المرور الجديدة لا تتطابق مع تأكيد كلمة مرور ',
          error: !status,
        );
        return false;
      } else if (!isGreater) {
        showsnakbar(
          Context: context,
          massage: 'يجب ان تكون كلمة المرور اكبر من او يساوي ست ارقام',
          error: !status,
        );
        return false;
      } else {
        showsnakbar(Context: context, massage: 'حدث خطا غير طبيعي');
      }
      return false;
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

  Future<void> updateProfile(Companies companies) async {
    bool status =
        await FbFirestoreControllerCompanies().Update(companies: companies);
    if (status) {
      showsnakbar(Context: context, massage: 'updated');
    }
  }

  Future<void> initConnectivity() async {
    //تحقق الاتصال بالانترنت
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
