import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/DeliveryCompany/reset_password.dart';
import 'package:random_string/random_string.dart';
import '../../controllers/fb_auth_controllers.dart';
import '../basic/helper.dart';

class ForgetPasswordCompany extends StatefulWidget {
  const ForgetPasswordCompany({Key? key}) : super(key: key);

  @override
  _ForgetPasswordCompanyState createState() => _ForgetPasswordCompanyState();
}

class _ForgetPasswordCompanyState extends State<ForgetPasswordCompany>
    with Helper {
  late TextEditingController _emailController;
  String? _emailError;
  bool isCheckEmail = false;
  String? number;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamCompanyForget;
  bool? determineTheInternetConnection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamCompanyForget =
        _firebaseFirestore.collection('Companies').snapshots();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          //TODO: go to previous page in a correct way
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),

        //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
        title: const Text(
          'ارسال البريد',
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
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: landscape * 0.036),
          children: [
            Padding(
              padding: EdgeInsets.only(top: landscape * 0.017),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: landscape * 0.005, left: 10),
                  child: const Text(
                    'أدخل البريد الالكتروني لتلقي رمز إعادة التعيين...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape * 0.118, left: 10, right: 10),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: _emailError,
                      label: const Text(
                        'البريد الإلكتروني ',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: streamCompanyForget,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> documentCompanyForget =
                            snapshot.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.only(top: 230),
                          child: Container(
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
                                  setState(() {
                                    number = randomNumeric(4);
                                  });
                                  for (QueryDocumentSnapshot v in documentCompanyForget) {
                                    if (_emailController.text ==
                                        v.get('gmail')) {
                                      isCheckEmail = true;
                                    }
                                  }
                                  if (checkData()) {
                                    if (isCheckEmail) {
                                      await performForgetPassword();
                                    } else {
                                      showsnakbar(
                                          Context: context,
                                          massage: 'البريد الألكتروني خاطأ',
                                          error: true);
                                    }
                                  }
                                }
                              },

                              child: const Text(
                                'ارسال',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ]),
            ),
          ]),
    );
  }

  Future<void> performForgetPassword() async {
    ModalBottomSheetMenucode(context: context, number: number!);
    isCheckEmail = false; //لاعادة الفحص
  }

  void controlError() {
    setState(() {
      _emailError = _emailController.text.isEmpty ? 'ادخل الايميل' : null;
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

  bool checkData() {
    if (_emailController.text.isNotEmpty) {
      controlError();
      return true;
    } else {
      controlError();
      showSnackBarMessage();
      return false;
    }

    //TODO: SHOW SNACK BAR
    showsnakbar(Context: context, massage: 'ادخل الحقل المطلوب', error: true);
    return false;
  }

  ModalBottomSheetMenucode(
      {required String number, required BuildContext context}) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: landscape * 0.557,
            child: Padding(
              padding: EdgeInsets.only(top: landscape * 0.103),
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: portrait * 0.341, right: portrait * 0.34),
                  width: landscape * 14.7,
                  height: portrait * 0.32,
                  decoration: const BoxDecoration(
                    color: Color(0xffffcc33),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: landscape * 0.032, bottom: landscape * 0.041),
                      child: Image.asset('images/BeeLogo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape * 0.23,
                      left: portrait * 0.206,
                      right: portrait * 0.206),
                  child: const Text(
                    'الكود الخاص بك هو' + ' ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape * 0.237,
                      left: portrait * 0.206,
                      right: portrait * 0.556),
                  child: Text(
                    number,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape * 0.23, right: portrait * 0.686),
                  child: GestureDetector(
                      child: const Icon(Icons.copy,
                          color: Color(0xffffcc33), size: 32),
                      onTap: () async {
                        _copyText(number);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestPassword(
                                      email: _emailController.text,
                                      code: number,
                                    )));
                      }),
                ),
              ]),
            ),
          );
        });
  }

  void _copyText(String text) {
    FlutterClipboard.copy(number!).then((value) {
      showsnakbar(Context: context, massage: 'Text copied');
    });
  }

  void clear() {
    _emailController.text = '';
  }

  Future<void> forgetPassword() async {
    bool status = await FbAuthControllers()
        .forgetPassword(context, email: _emailController.text);
    if (status) {
      Navigator.pushReplacementNamed(context, '/online_login_screen');
    }
  }

  Future<void> initConnectivity() async {//كود الاتصال بالانترنت
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
