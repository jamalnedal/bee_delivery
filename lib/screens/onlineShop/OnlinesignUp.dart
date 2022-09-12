import 'package:flutter/material.dart';
import '/models/preNumber.dart';
import '/models/registar_shop_owners.dart';
import '/screens/basic/helper.dart';
import '../../controllers/fb-fir-stor-shop_owners.dart';
import '../../controllers/fb_auth_controllers.dart';
import '../../models/city.dart';

class OnlineShopSignUp extends StatefulWidget {
  const OnlineShopSignUp({Key? key}) : super(key: key);

  @override
  State<OnlineShopSignUp> createState() => _OnlineShopSignUpState();
}

class _OnlineShopSignUpState extends State<OnlineShopSignUp> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _storeNameController;
  late TextEditingController _passwordController;
  late TextEditingController _mobileController;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  String? _emailError;
  String? _passwordError;
  String? _firstError;
  String? _lastError;
  String? _descriptionError;
  String? _confirmPasswordError;
  String? _storeNameError;
  String? _mobileError;
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
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _storeNameController = TextEditingController();
    _mobileController = TextEditingController();
    _selectedNum = '+970';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _descriptionController.dispose();
    _confirmPasswordController.dispose();
    _storeNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.all(40.0),
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          height: double.infinity,
          child: ListView(shrinkWrap: true, children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                errorText: _firstError,
                label: const Text(
                  'الاسم الأول ',
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
              controller: _lastNameController,
              decoration: InputDecoration(
                errorText: _lastError,
                label: const Text(
                  'الاسم الأخير ',
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
              controller: _storeNameController,
              decoration: InputDecoration(
                errorText: _storeNameError,
                label: const Text(
                  'اسم المتجر ',
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
                      width: 80,
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
                obscureText: _obscureTextPassword,
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
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                    icon: Icon(
                        _obscureTextPassword
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
                obscureText: _obscureTextConfirmPassword,
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
                  await performRegistrationShopOwners();
                  // await delet();
                },

                child: const Text(
                  ' إنشاء حساب',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ),
          ]),
        ));
  }

  Future<void> performRegistrationShopOwners() async {
    if (checkData() && checkMobile() && checkPassword()) {
      await registerShopOwners();
      await createRegistrationInformationCollection();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _storeNameController.text.isNotEmpty &&
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
      _firstError =
          _firstNameController.text.isEmpty ? 'ادخل الاسم الاول' : null;
      _lastError =
          _lastNameController.text.isEmpty ? 'ادخل الاسم الاخير' : null;
      _storeNameError =
          _storeNameController.text.isEmpty ? 'ادخل اسم المتجر' : null;
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
    bool statusLengthen = _passwordController.text.length >= 6;
    bool statusEqual =
        _passwordController.text == _confirmPasswordController.text;
    bool checkPassword = statusLengthen && statusEqual;
    if (checkPassword) {
      return true;
    } else {
      if (!statusLengthen) {
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
  }

  bool checkMobile() {
    bool statusStart =
        _mobileController.text[0] + _mobileController.text[1] == '59';
    bool statusLengthOfNumber = _mobileController.text.length == 9;
    bool status = statusStart && statusLengthOfNumber;
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

  Future<void> registerShopOwners() async {
    bool status = await FbAuthControllers().createAccount(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
    if (status) {
      Navigator.pushNamed(context, '/online_login_screen');
    }
  }

  Future<void> createRegistrationInformationCollection() async {
    await FbFirestoreRegistrationShopOwnersController()
        .crateShopOwners(shopOwners: shopOwners);
  }

  ShopOwners get shopOwners {
    ShopOwners owners = ShopOwners();
    owners.gmail = _emailController.text;
    owners.firstName = _firstNameController.text;
    owners.lastName = _lastNameController.text;
    owners.city = _selectedCity!;
    owners.mobile = _selectedNum! + _mobileController.text;
    owners.password = _passwordController.text;
    owners.storeName = _storeNameController.text;
    owners.description = _descriptionController.text;
    return owners;
  }
}
