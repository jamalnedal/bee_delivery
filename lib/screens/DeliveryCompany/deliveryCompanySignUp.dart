import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/register_companies.dart';
import '../../controllers/fb_fir_store_companies.dart';
import '../../models/city.dart';
import '../../models/preNumber.dart';
import '../basic/helper.dart';

class DeliveryCompanySignUp extends StatefulWidget {
  const DeliveryCompanySignUp({Key? key}) : super(key: key);

  @override
  State<DeliveryCompanySignUp> createState() => _OnlineShopSignUpState();
}

class _OnlineShopSignUpState extends State<DeliveryCompanySignUp> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _telephoneFixController;
  late TextEditingController _mobileController;
  late TextEditingController _companyNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamCompanyRegestratione;
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  String? _emailError;
  String? _passwordError;
  String? _companyNAmeError;
  String? _telephoneFixError;
  String? _descriptionError;
  String? _confirmPasswordError;
  String? _mobileError;
  bool isCheckEmail = false; //لفحص اذا الجميل المدخل موجود او لا
  bool? determineTheInternetConnection;

  @override
  void initState() {
    super.initState();
    streamCompanyRegestratione =
        _firebaseFirestore.collection('Companies').snapshots();
    _emailController = TextEditingController();
    _companyNameController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _descriptionController = TextEditingController();
    _telephoneFixController = TextEditingController();
    _selectedNum = '+970';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _companyNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _descriptionController.dispose();
    _telephoneFixController.dispose();
    super.dispose();
  }

  final List<City> _city = <City>[
    City(id: 1, name: 'طولكرم'),
    City(id: 2, name: 'الخليل'),
    City(id: 3, name: 'نابلس'),
    City(id: 4, name: 'أريحا'),
    City(id: 5, name: 'بيت لحم'),
    City(id: 6, name: 'القدس'),
  ];

  final List<PreNum> _pre = <PreNum>[
    PreNum(id: 1, num: '+970'),
    PreNum(id: 2, num: '+972'),
  ];
  String? _selectedCity;
  String? _selectedNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            //TODO: go to previous page in a correct way
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),

          //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
          title: const Text(
            'التسجيل',
            style: TextStyle(
                fontFamily: 'Tajwal',
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
          padding: const EdgeInsets.all(40.0),
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          height: double.infinity,
          child: ListView(shrinkWrap: true, children: [
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(
                errorText: _companyNAmeError,
                label: const Text(
                  'اسم الشركة',
                  style: TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                ),
                prefixIcon: const Icon(
                  Icons.text_format,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorText: _emailError,
                label: const Text(
                  'البريد الإلكتروني ',
                  style: TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                ),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _telephoneFixController,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  errorText: _telephoneFixError,
                  icon: const Icon(
                    Icons.phone,
                  ),
                  label: const Text(
                    "الهاتف الأرضي",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                      controller: _mobileController,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        errorText: _mobileError,
                        icon: const Icon(
                          Icons.phone,
                        ),
                        label: const Text(
                          "الهاتف المحمول",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Tajawal'),
                        ),
                      )),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 70,
                      height: 80,
                      child: DropdownButton<String>(
                        value: _selectedNum,
                        items: _pre.map(
                          (e) {
                            return DropdownMenuItem(
                                value: e.num, child: Text(e.num));
                          },
                        ).toList(),
                        isExpanded: true,
                        onTap: () {},
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedNum = value;
                            });
                          }
                        },
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton<String>(
                icon: const Icon(
                  Icons.location_city,
                ),
                hint: const Text('المدينة'),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal'),
                value: _selectedCity,
                items: _city.map(
                  (e) {
                    return DropdownMenuItem(value: e.name, child: Text(e.name));
                  },
                ).toList(),
                isExpanded: true,
                onTap: () {},
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedCity = value;
                    });
                  }
                },
                elevation: 4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _passwordController,
                obscureText: obscureTextPassword,
                decoration: InputDecoration(
                  errorText: _passwordError,
                  icon: const Icon(
                    Icons.lock,
                  ),
                  label: const Text(
                    "ادخل كلمة المرور",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
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
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _confirmPasswordController,
                obscureText: obscureTextConfirmPassword,
                decoration: InputDecoration(
                  errorText: _confirmPasswordError,
                  icon: const Icon(
                    Icons.lock,
                  ),
                  label: const Text(
                    "تأكيد كلمة المرور",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextConfirmPassword = !obscureTextConfirmPassword;
                      });
                    },
                    icon: Icon(
                        obscureTextConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xffffcc33)),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  errorText: _descriptionError,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  counterText: '',
                  icon: const Icon(
                    Icons.description,
                  ),
                  suffixIcon: const Icon(Icons.send),
                  label: const Text(
                    "الوصف",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: streamCompanyRegestratione,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<QueryDocumentSnapshot> documentCompanyRegestratione =
                        snapshot.data!.docs;
                    return Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black, width: 1),
                        color: const Color(0xffffcc33),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      //margin : const EdgeInsets.only(left: 50),
                      child: MaterialButton(
                        //زر لتاكيد تسجيل الدخول
                        onPressed: () async {
                          await initConnectivity();
                          ///////////   هذا الكود لفحص جميع الجميلات تم التحقق ان الجميل موجود سابقا ام لا
                          if (determineTheInternetConnection == false) {
                            showsnakbar(
                                Context: context,
                                massage: 'غير متصل بالانترنت حاليا',
                                error: true);
                          } else {
                            for (QueryDocumentSnapshot v
                                in documentCompanyRegestratione) {
                              if (_emailController.text == v.get('gmail')) {
                                isCheckEmail = true;
                              }
                            }
                            if (isCheckEmail) {
                              showsnakbar(
                                  Context: context,
                                  massage: 'البريد الألكتروني موجود مسبقا',
                                  error: true);
                              isCheckEmail =
                                  false; //////هذا السطر لارجاع فحص العملية مع كل ضغطة
                            } else {
                              await performRegistrationCompanies();
                            }
                          }
                        },
                        child: const Text(
                          ' إنشاء حساب',
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
        ));
  }

  Future<void> performRegistrationCompanies() async {
    if (checkData() &&
        checkEmail() &&
        checkTelephoneFixController() &&
        checkMobile() &&
        checkPassword()) {
      await registerCompanyCollection();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _companyNameController.text.isNotEmpty &&
        _telephoneFixController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedCity != null &&
        _selectedNum != null) {
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
      _emailError = _emailController.text.isEmpty ? 'ادخل الايميل' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'ادخل كلمة المرور' : null;
      _companyNAmeError =
          _companyNameController.text.isEmpty ? 'ادخل اسم الشركة' : null;
      _telephoneFixError = _telephoneFixController.text.isEmpty
          ? 'ادخل رقم الهاتم الارضي'
          : null;
      _descriptionError =
          _descriptionController.text.isEmpty ? 'ادخل الوصف' : null;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty
          ? 'ادخل تاكيد كلمة المرور'
          : null;
      _mobileError = _mobileController.text.isEmpty ? 'ادخل الموبايل' : null;
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

  bool checkPassword() {
    bool statusEcual =
        _passwordController.text == _confirmPasswordController.text;
    bool statusLength = _passwordController.text.length >= 6;
    bool status = statusEcual && statusLength;
    if (status) {
      return true;
    } else {
      if (statusEcual == false) {
        showsnakbar(
          Context: context,
          massage: 'كلمة المرور الجديدة لا تتطابق مع تأكيد كلمة مرور ',
          error: !status,
        );
        return false;
      } else if (statusLength == false) {
        showsnakbar(
            Context: context,
            massage: 'يجب ان تكون كلمة المرور ست حروف او اكبر ',
            error: !status);
      }
      return false;
    }
  }

  bool checkEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);
    if (emailValid) {
      return true;
    } else {
      showsnakbar(
          Context: context,
          massage: 'قم بتحقق من كتابة البريد الالكتروني المدخل',
          error: true);
      return false;
    }
  }

  bool checkMobile() {
    bool statusStart =
        _mobileController.text[0] + _mobileController.text[1] == '59';
    bool status = statusStart && _mobileController.text.length == 9;
    if (status) {
      return true;
    } else {
      if (statusStart == false) {
        showsnakbar(
          Context: context,
          massage: 'رقم الهاتف يجب ان يبدا ب 59 ',
          error: !status,
        );
        return false;
      } else {
        showsnakbar(
          Context: context,
          massage: 'يجب ان يكون رقم الهاتف تسع ارقام',
          error: !status,
        );
        return false;
      }
    }
  }

  bool checkTelephoneFixController() {
    bool statusStart =
        _telephoneFixController.text[0] + _telephoneFixController.text[1] ==
            '08';
    bool statusEcual = _telephoneFixController.text.length == 9;
    bool status = statusStart && statusEcual;
    if (status) {
      return true;
    } else {
      if (statusStart == false) {
        showsnakbar(
          Context: context,
          massage: 'رقم الهاتف الارضي يجب ان يبدأ ب 08',
          error: !status,
        );
        return false;
      } else if (statusEcual == false) {
        showsnakbar(
            Context: context,
            massage: 'يجب ان يتكون رقم الهاتف الارضي من تسع ارقام',
            error: !status);
      }
    }
    return false;
  }

  Future<void> registerCompanyCollection() async {
    await FbFirestoreControllerCompanies().crate(companies: companies);
    Navigator.pushNamed(context, '/deliveryCompany_login_screen');
    showsnakbar(Context: context, massage: 'تم انشاء الحساب بنجاح');
  }

  Companies get companies {
    Companies company = Companies();
    company.gmail = _emailController.text;
    company.telephoneFix = _telephoneFixController.text;
    company.city = _selectedCity!;
    company.mobile = _selectedNum! + _mobileController.text;
    company.password = _passwordController.text;
    company.companyName = _companyNameController.text;
    company.description = _descriptionController.text;
    return company;
  }

  Future<void> initConnectivity() async {
    ///////////////كود الاتصال بالانترنت
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
