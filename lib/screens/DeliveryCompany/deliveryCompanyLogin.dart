import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/basic/helper.dart';
import '../../pref/shared_pref_controller.dart';

class DeliveryCompanyLoginScreen extends StatefulWidget {
  const DeliveryCompanyLoginScreen({Key? key}) : super(key: key);

  @override
  _DeliveryCompanyLoginScreen createState() => _DeliveryCompanyLoginScreen();
}

class _DeliveryCompanyLoginScreen extends State<DeliveryCompanyLoginScreen>
    with Helper {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamCompanyRegestratione;
  QueryDocumentSnapshot? documentCompanyName;
  bool obscureTextPassword = true;
  String? _emailError;
  String? _passwordError;
  bool isCheckEmail = false;
  bool? determineTheInternetConnection;

  @override
  void initState() {
    super.initState();
    streamCompanyRegestratione =
        _firebaseFirestore.collection('Companies').snapshots();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
        title: const Text(
          'تسجيل الدخول',
          style: TextStyle(
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),

        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, "/delivery_user_specify_screen");
            }),
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
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(40.0),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                // بوكس بارتفاع معين ليعطيني مساحه بين العناصر
                height: 100.0,
              ),
              const SizedBox(
                  //margin:const EdgeInsets.only(top: 0),
                  width: 400,
                  height: 200,
                  child: Image(
                    image: AssetImage('images/BeeLogo.png'),
                  )),
              const SizedBox(
                // بوكس بارتفاع معين ليعطيني مساحه بين العناصر
                height: 50.0,
              ),
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: _emailError,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1)),
                  label: const Text(
                    'البريد الإلكتروني',
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Color(0xffffcc33)),
                  //suffixIcon: const Icon(Icons.send),
                  counterText: '',
                  helperText: 'مثال :beeDelivery2021@gmail.com ',
                  helperStyle: const TextStyle(fontFamily: 'Tajawal'),
                  labelStyle: const TextStyle(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),

                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),
                  fillColor: Colors.grey,
                  // TextField Background Color
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: _passwordTextController,
                obscureText: obscureTextPassword,
                decoration: InputDecoration(
                    errorText: _passwordError,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1)),
                    label: const Text(
                      'كلمة المرور',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                    ),
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xffffcc33)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
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
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black,
                        ))),
              ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: streamCompanyRegestratione,
                  //كود استدعاء لكل المدراء لفحص حالة الدخول
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> documentCompanyLogin =
                          snapshot.data!.docs;
                      return Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffffcc33), width: 1),
                          color: const Color(0xffffcc33),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30),
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
                              for (QueryDocumentSnapshot v
                                  in documentCompanyLogin) {
                                if (_passwordTextController.text ==
                                        v.get('password') &&
                                    _emailTextController.text ==
                                        v.get('gmail')) {
                                  isCheckEmail = true;
                                  documentCompanyName = v; //حفظ اسم الشركة
                                }
                              }
                              if (checkData()) {
                                //التحقق من البيانات قبل الدخول
                                if (isCheckEmail) {
                                  await performLoginCompanies(
                                      documentCompanyName!.get(
                                          'companyName')); //هذا السطر لحفظ اسم الشركة قبل دخول التطبيق
                                } else {
                                  showsnakbar(
                                      Context: context,
                                      massage:
                                          'كلمة المرور او البريد الالكتروني خطا',
                                      error: true);
                                }
                              }
                            }
                          },

                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ForgetPasswordCompany');
                  },
                  child: const Text(
                    'نسيت كلمةالمرور؟',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        //fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                ),
              ),
            ]),
          )),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Material(
                child: Container(
                  padding: const EdgeInsets.only(right: 20, bottom: 40),
                  width: double.infinity,
                  child: const Text(
                    'حساب جديد',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/deliveryCompany_signUp');
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 20, bottom: 40),
                  width: 100,
                  child: const Center(
                    child: Icon(
                      Icons.arrow_circle_left,
                      color: Color(0xffffcc33),
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLoginCompanies(String companyName) async {
    await loginCompanies(companyName);
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      controlError();
      return true;
    }
    controlError();
    showSnackBarMessage();
    return false;
  }

  void controlError() {
    setState(() {
      _emailError =
          _emailTextController.text.isEmpty ? 'ادخل اسم المستخدم' : null;

      _passwordError =
          _passwordTextController.text.isEmpty ? 'ادخل كلمة المرور' : null;
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

  Future<void> loginCompanies(String companyName) async {
    await SharedPrefController().saveLoginCompaniese(
        gmail: _emailTextController.text,
        password: _passwordTextController.text,
        companyName: companyName);
    Navigator.pushNamed(context, '/deliveryCompany_bn_screen');
  }

  Future<void> initConnectivity() async {
    //////////////كود فحص الانترنت
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
