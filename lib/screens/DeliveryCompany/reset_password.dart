import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb_fir_store_companies.dart';
import '/models/register_companies.dart';
import '../../style_text_field/textfilde.dart';
import '../basic/helper.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({Key? key, required this.email, this.code})
      : super(key: key);
  final String? email;
  final String? code;

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> with Helper {
  late QueryDocumentSnapshot documentSnapshot;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamCompanyResetPassword;
  late TextEditingController _firstCodeController;
  late TextEditingController _secondCodeController;
  late TextEditingController _thirdCodeController;
  late TextEditingController _fourthCodeController;
  late TextEditingController _newPasswordController;
  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _forthFocusNode;
  bool? determineTheInternetConnection;
  String? passwordNewError;
  String? passwordConfirmError;

  late TextEditingController _confirmPasswordController;
  String code = '';
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    streamCompanyResetPassword = _firebaseFirestore
        .collection("Companies")
        .where("gmail", isEqualTo: widget.email)
        .snapshots();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstCodeController = TextEditingController();
    _secondCodeController = TextEditingController();
    _thirdCodeController = TextEditingController();
    _fourthCodeController = TextEditingController();
    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _forthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _firstCodeController.dispose();
    _secondCodeController.dispose();
    _thirdCodeController.dispose();
    _fourthCodeController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _forthFocusNode.dispose();

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
            'اعادة تعين كلمة السر',
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
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 40),
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            height: double.infinity,
            child: ListView(shrinkWrap: true, children: [
              Column(children: [
                const Text(
                  "اعادة تعين كلمة المرور....",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                Text(
                  "ادخل الكود المطلوب&&وكلمة السر الجديدة",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppCodeTextField(
                        onChanged: (String value) {
                          if (value.isEmpty) {
                            _thirdFocusNode.requestFocus();
                          }
                        },
                        controller: _fourthCodeController,
                        focusNode: _forthFocusNode,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: AppCodeTextField(
                        onChanged: (String value) {
                          value.isNotEmpty
                              ? _forthFocusNode.requestFocus()
                              : _secondFocusNode.requestFocus();
                        },
                        controller: _thirdCodeController,
                        focusNode: _thirdFocusNode,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: AppCodeTextField(
                        onChanged: (String value) {
                          value.isNotEmpty
                              ? _thirdFocusNode.requestFocus()
                              : _firstFocusNode.requestFocus();
                        },
                        controller: _secondCodeController,
                        focusNode: _secondFocusNode,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: AppCodeTextField(
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            _secondFocusNode.requestFocus();
                          }
                        },
                        controller: _firstCodeController,
                        focusNode: _firstFocusNode,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(width: 5),
                Container(
                    padding: const EdgeInsets.only(top: 40),
                    width: 400,
                    height: 200,
                    child: const Image(
                      image: AssetImage('images/BeeLogo.png'),
                    )),
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
                  obscureText: _obscureTextPassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _newPasswordController,
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
                          _obscureTextPassword = !_obscureTextPassword;
                        });
                      },
                      icon: Icon(
                          _obscureTextPassword
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
                  obscureText: _obscureTextConfirmPassword,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal'),
                  controller: _confirmPasswordController,
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
                          _obscureTextConfirmPassword =
                              !_obscureTextConfirmPassword;
                        });
                      },
                      icon: Icon(
                          _obscureTextConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xffffcc33)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: streamCompanyResetPassword,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> documentCompanyReset =
                            snapshot.data!.docs;
                        //كود استدعاء معلومات الشخص الذس يقوم بعملية اعادة التعين لاعادة الحفظ من جديد في الكولكشن
                        documentSnapshot = documentCompanyReset[0];
                        return Container(
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
                              } else {
                                performRegister();
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
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ]),
            ])));
  }

  bool performRegister() {
    if (checkCode() && checkData() && checkPassword()) {
      companies(documentSnapshot, true);
      return true;
    }
    return false;
  }

  bool checkCode() {
    code = _firstCodeController.text +
        _secondCodeController.text +
        _thirdCodeController.text +
        _fourthCodeController.text;
    if (code.length != 4) {
      showsnakbar(
          Context: context, massage: 'ادخل الاربع حقول كاملة', error: true);
    } else {
      if (code != widget.code) {
        showsnakbar(
            Context: context, massage: 'الكود المدخل خاطئ', error: true);
      }
    }

    return code.length == 4 && code == widget.code;
  }

  bool checkPassword() {
    bool agree = _newPasswordController.text == _confirmPasswordController.text;
    bool isGreater = _newPasswordController.text.length >= 6;
    bool status = agree && isGreater;
    if (status) {
      return true;
    } else {
      if (!agree) {
        showsnakbar(
          Context: context,
          massage: 'كلمة المرور الجديدة لا تتطابق مع تأكيد كلمة مرور ',
          error: !status,
        );
        return false;
      } else if (!isGreater) {
        showsnakbar(
          Context: context,
          massage: 'يجب ان تكون كلمة المرو اكبر من او يساوي ست ارقام',
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
    if (_newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
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
      passwordNewError =
          _newPasswordController.text.isEmpty ? 'ادخل كلمة السر الجديدة' : null;
      passwordConfirmError = _confirmPasswordController.text.isEmpty
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

  Companies companies(documentSnapshot, caseEdite) {
    bool password = _newPasswordController.text == '';
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
        : _newPasswordController.text;
    if (caseEdite) {
      updateProfile(companies);
    }
    return companies;
  }

  Future<void> updateProfile(Companies companies) async {
    //تعديل البروفايل بعد تعين كلمة السر الجديدة
    bool status =
        await FbFirestoreControllerCompanies().Update(companies: companies);
    if (status) {
      showsnakbar(Context: context, massage: 'updated');
      Navigator.pushNamed(context, '/deliveryCompany_login_screen');
    }
  }

  Future<void> initConnectivity() async {
    /////كود الفحص الخاص بالانترنت
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
}
