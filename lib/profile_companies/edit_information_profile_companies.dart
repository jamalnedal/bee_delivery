import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb_fir_store_companies.dart';
import '/models/preNumber.dart';
import '/models/register_companies.dart';
import '/screens/basic/helper.dart';
import '../../models/city.dart';

class EditInformationProfileCompanies extends StatefulWidget {
  const EditInformationProfileCompanies({Key? key, required this.companies})
      : super(key: key);
  final Companies? companies;

  @override
  State<EditInformationProfileCompanies> createState() =>
      _EditInformationProfileCompaniesState();
}

class _EditInformationProfileCompaniesState
    extends State<EditInformationProfileCompanies> with Helper {
  late TextEditingController _telephoneFixController;
  late TextEditingController _descriptionController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _mobileController;
  String? _descriptionError;
  String? _telephoneFix;
  String? _mobileError;
  bool? determineTheInternetConnection;
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
    _descriptionController =
        TextEditingController(text: widget.companies?.description ?? '');
    _telephoneFixController =
        TextEditingController(text: widget.companies?.telephoneFix ?? '');
    _mobileController = TextEditingController(
        text: widget.companies?.mobile.substring(4) ?? '');
    _selectedCity = widget.companies?.city ?? '';
    _selectedNum = '+970';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _telephoneFixController.dispose();
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
          padding:
              const EdgeInsets.only(right: 40, left: 40, bottom: 40, top: 20),
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          height: double.infinity,
          child: Column(children: [
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                TextField(
                  style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  controller: _telephoneFixController,
                  decoration: InputDecoration(
                    errorText: _telephoneFix,
                    label: const Text(
                      'الهاتف الارضي ',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
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
                        return DropdownMenuItem(
                            value: e.name, child: Text(e.name));
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 40),
                      counterText: '',
                      icon: const Icon(
                        Icons.description,
                      ),
                      suffixIcon: const Icon(Icons.send),
                      label: const Text(
                        "الوصف",
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
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
                        await performCompaniesInformationProfile();
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
            ),
          ]),
        ));
  }

  Future<void> performCompaniesInformationProfile() async {
    if (checkData() && checkTelephoneFixController() && checkMobile()) {
      await _UpdateProfile();
    }
  }

  bool checkData() {
    if (_mobileController.text.isNotEmpty &&
        _telephoneFixController.text.isNotEmpty &&
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
      _telephoneFix =
          _telephoneFixController.text.isEmpty ? 'ادخل الهاتف الارضي' : null;
      _mobileError = _mobileController.text.isEmpty ? 'ادخل رقم الجوال' : null;
      _descriptionError =
          _descriptionController.text.isEmpty ? 'ادخل الوصف' : null;
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

  Future<void> _UpdateProfile() async {
    bool status =
        await FbFirestoreControllerCompanies().Update(companies: companies);
    if (status) {
      showsnakbar(Context: context, massage: 'updated');
      Navigator.pushNamed(context, '/editProfileCompany');
    }
  }

  Companies get companies {
    Companies companies = Companies();
    companies.id = widget.companies!.id;
    companies.companyName = widget.companies!.companyName;
    companies.gmail = widget.companies!.gmail;
    companies.telephoneFix = _telephoneFixController.text;
    companies.mobile = _selectedNum! + _mobileController.text;
    companies.city = _selectedCity!;
    companies.description = _descriptionController.text;
    companies.password = widget.companies!.password;
    return companies;
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
