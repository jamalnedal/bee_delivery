import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../pref/shared_pref_controller.dart';
import '../basic/helper.dart';

class DeliveryManLoginScreen extends StatefulWidget {
  const DeliveryManLoginScreen({Key? key}) : super(key: key);

  @override
  _DeliveryManLoginScreen createState() => _DeliveryManLoginScreen();
}

class _DeliveryManLoginScreen extends State<DeliveryManLoginScreen>
    with Helper {
  late TextEditingController _identificationNumber;
  late TextEditingController _passwordTextController;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamLoginManDelivery;
  QueryDocumentSnapshot? documentManNameAndCompanyName;
  bool obscureTextPassword = true;
  String? _emailError;
  String? _passwordError;
  bool isCheckEmail = false;
  bool? determineTheInternetConnection;

  @override
  void initState() {
    super.initState();
    streamLoginManDelivery = _firebaseFirestore.collection('Men').snapshots();
    _identificationNumber = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _identificationNumber.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios),
          //   //TODO: go to previous page in a correct way
          //   onPressed: () => Navigator.pop(context),
          //   color: Colors.black,
          // ),

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
                  controller: _identificationNumber,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: _emailError,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1)),
                    label: const Text(
                      'رقم الهوية',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                    ),
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xffffcc33)),
                    //suffixIcon: const Icon(Icons.send),
                    counterText: '',
                    helperText: 'مثال : 401236910',
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
                  height: 25.0,
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
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
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
                    stream: streamLoginManDelivery,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> documentLoginDelivery =
                            snapshot.data!.docs;
                        return Container(
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffffcc33),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                                    in documentLoginDelivery) {
                                  if (_passwordTextController.text ==
                                          v.get('password') &&
                                      _identificationNumber.text ==
                                          v.get('identificationNumber')) {
                                    isCheckEmail = true;
                                    documentManNameAndCompanyName = v;
                                  }
                                }
                                if (checkData()) {
                                  if (isCheckEmail) {
                                    await performLoginManDelivery(
                                        documentManNameAndCompanyName!
                                            .get('firstName'),
                                        documentManNameAndCompanyName!
                                            .get('companyName'));
                                  } else {
                                    showsnakbar(
                                        Context: context,
                                        massage:
                                            'خطأ في رقم الهوية او كلمة المرور',
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
                        return CircularProgressIndicator();
                      }
                    }),
                const SizedBox(
                  height: 60,
                ),
              ]),
            )));
  }

  Future<void> performLoginManDelivery(String name, String companyName) async {
    await loginManDelivery(name, companyName);
  }

  bool checkData() {
    if (_identificationNumber.text.isNotEmpty &&
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
          _identificationNumber.text.isEmpty ? 'ادخل رقم الهوية' : null;

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

  Future<void> loginManDelivery(String name, String companyName) async {
    await SharedPrefController().saveLoginMan(
        identificationNumberMan: _identificationNumber.text,
        password: _passwordTextController.text,
        name: name,
        companyName: companyName);
    Navigator.pushNamed(context, '/deliveryMan_bn_screen');
  }

  Future<void> initConnectivity() async {
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
