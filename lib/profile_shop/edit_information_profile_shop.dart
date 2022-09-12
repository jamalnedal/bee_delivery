import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/preNumber.dart';
import '/models/registar_shop_owners.dart';
import '/screens/basic/helper.dart';
import '../../controllers/fb-fir-stor-shop_owners.dart';
import '../../models/city.dart';

class EditInformationProfileShop extends StatefulWidget {
  const EditInformationProfileShop({Key? key, required this.shopOwners})
      : super(key: key);
  final ShopOwners? shopOwners;//الاوبجكت المرسول لقراءة معلومات البروفايل الاخرى غير كلمة السر

  @override
  State<EditInformationProfileShop> createState() =>
      _EditInformationProfileShopState();
}

class _EditInformationProfileShopState extends State<EditInformationProfileShop>with Helper {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _storeNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _mobileController;
  String? _firstError;
  String? _lastError;
  String? _storeNameError;
  String? _descriptionError;
  String? _mobileError;
  bool? determineTheInternetConnection; //تحديد اتصال الانترنت
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
    _firstNameController =
        TextEditingController(text: widget.shopOwners?.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.shopOwners?.lastName ?? '');
    _storeNameController =
        TextEditingController(text: widget.shopOwners?.storeName ?? '');
    _descriptionController =
        TextEditingController(text: widget.shopOwners?.description ?? '');
    _mobileController = TextEditingController(
        text: widget.shopOwners?.mobile.substring(4) ?? '');
    _selectedCity = widget.shopOwners?.city ?? '';
    _selectedNum = '+970';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _storeNameController.dispose();
    _descriptionController.dispose();
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
            'تعديل الحساب',
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
              style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
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
              style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
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
              style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
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
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                      style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
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
                          style: const TextStyle(
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
                        style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
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
            const SizedBox(
              height: 20,
            ),
            TextField(
                style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
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
                  await initConnectivity();
                  if (determineTheInternetConnection == false) {
                    showsnakbar(
                        Context: context,
                        massage: 'غير متصل بالانترنت حاليا',
                        error: true);
                  } else if (determineTheInternetConnection == true) {
                    performUpdateProfile();
                  }
                },

                child: const Text(
                  ' تعديل الحساب',
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

  Future<void> performUpdateProfile() async {
    if (checkData() && checkMobile()) {
      await updateProfile();
    }
  }

  bool checkData() {
    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _storeNameController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedCity != null&&
        _selectedNum != null) {
      controlError();
      return true;
    } else {
      controlError();
      showSnackBarMessage();
      print(_storeNameController.text==' ');
      return false;
    }
  }

  void controlError() {
    setState(() {
      _firstError =
          _firstNameController.text.isEmpty ? 'ادخل الاسم الاول' : null;
      _lastError =
          _lastNameController.text.isEmpty ? 'ادخل الاسم الاخير' : null;

      _storeNameError =
      _storeNameController.text.isEmpty? 'ادخل اسم المتجر' : null;

      _descriptionError =
          _descriptionController.text.isEmpty ? 'ادخل الوصف' : null;

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
          massage: 'يجب ان يكون رقم الهاتف تسعة أرقام',
          error: !status,
        );
        return false;
      }
    }
  }

  Future<void> updateProfile() async {
    bool status = await FbFirestoreRegistrationShopOwnersController()
        .updateShopOwners(shopOwners: shopOwners);
    if (status) {
      showsnakbar(Context: context, massage: 'updated');
      Navigator.pushNamed(context, '/EditProfileShop');
    }
  }

  ShopOwners get shopOwners {
    ShopOwners shopOwner = ShopOwners();
    shopOwner.id = widget.shopOwners!.id;
    shopOwner.firstName = _firstNameController.text;
    shopOwner.lastName = _lastNameController.text;
    shopOwner.storeName = _storeNameController.text;
    shopOwner.mobile = _selectedNum! + _mobileController.text;
    shopOwner.city = _selectedCity!;
    shopOwner.description = _descriptionController.text;
    shopOwner.password = widget.shopOwners!.password;
    shopOwner.gmail = widget.shopOwners!.gmail;
    return shopOwner;
  }

  Future<void> initConnectivity() async {/////////////////////////////////دوال فحص الاتصال بالانترنت
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
