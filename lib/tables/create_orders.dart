import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/map/add_order_map.dart';
import '/controllers/fb_fir_store_companies.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';
import '/screens/basic/helper.dart';
import 'package:random_string/random_string.dart';

import '../controllers/fb_fir_store_orders.dart';
import '../models/city.dart';
import '../models/preNumber.dart';


//ملف إنشاء طلب
class CreateOrders extends StatefulWidget {
  const CreateOrders({Key? key, required this.title, this.orders})
      : super(key: key);
  final String title;
  final Orders? orders;

  @override
  State<CreateOrders> createState() => _CreateOrdersState();
}

class _CreateOrdersState extends State<CreateOrders> with Helper {
  late TextEditingController _firstNameController;
  late TextEditingController _mobileController;
  late TextEditingController _locationController;
  String? firstNameError;
  String? mobileError;
  String? locationError;
  bool? determineTheInternetConnection;
  double latitude = 0;
  double longitude = 0;
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
  String? _selectedCompany;
  String? _selectedNum;
  String? trackingNumber;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.orders?.firstName ?? '');
    _mobileController =
        TextEditingController(text: widget.orders?.mobile.substring(4) ?? '');
    _locationController =
        TextEditingController(text: widget.orders?.location ?? '');
    if (widget.orders != null) {
      _selectedCompany = widget.orders?.deliveryCompany ?? '';
    }
    _selectedNum = '+970';
    //_selectedCompany=widget.orders?.deliveryCompany??'';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
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
          title: Text(
            widget.title,
            style: const TextStyle(
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
            padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            height: double.infinity,
            child: Column(children: [
              Expanded(
                child: ListView(children: [
                  TextField(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      errorText: firstNameError,
                      label: const Text(
                        'الاسم ',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
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
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                    controller: _locationController,
                    decoration: InputDecoration(
                      errorText: locationError,
                      label: const Text(
                        'الموقع ',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
                      ),
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      counterText: '',
                      helperText: 'مثال :فلسطين/قطاع غزة/رفح/شارع النص ',
                      helperStyle: const TextStyle(fontFamily: 'Tajawal'),
                      labelStyle: const TextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: latitude == 0 && longitude == 0,
                    replacement: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'احداثيات الموقع المختار:\n$latitude,$longitude',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Tajawal'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffffcc33),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.transparent,
                              ),
                            ),
                            fixedSize: const Size(double.infinity, 30),
                          ),
                            onPressed: () async {
                              List<double> data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddOrderMap()));
                              setState(() {
                                latitude = 0;
                                longitude = 0;
                              });
                              setState(() {
                                latitude = data[0];
                                longitude = data[1];
                              });
                            },
                            child: Text('تغيير الموقع' ,textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Tajawal'),
                            ),)
                      ],
                    ),
                    child: ElevatedButton(

                      onPressed: () async {
                        List<double> data = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddOrderMap()));
                        setState(() {
                          latitude = data[0];
                          longitude = data[1];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffffcc33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.transparent,
                          ),
                        ),
                        fixedSize: const Size(double.infinity, 30),
                      ),
                      child: Row(
                        children: const [
                          Flexible(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'حدد الموقع على الخريطة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Tajawal'),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
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
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Tajawal'),
                            controller: _mobileController,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              errorText: mobileError,
                              icon: const Icon(
                                Icons.phone_iphone_outlined,
                              ),
                              label: const Text(
                                "الهاتف المحمول",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Tajawal'),
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
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Tajawal'),
                              hint: const Text('المقدمة'),
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
                    child: StreamBuilder<QuerySnapshot>(
                        stream:
                            FbFirestoreControllerCompanies().readCompanies(),
                        //دالة استدعاء لكل المدراء في الداتابيز
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Transform.scale(
                              scale: 5,
                              child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            List<QueryDocumentSnapshot> documentAllCompanies =
                                snapshot.data!.docs;
                            return DropdownButton<String>(
                              icon: const Icon(
                                Icons.business_outlined,
                              ),
                              hint: const Text('الشركات'),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Tajawal'),
                              value: _selectedCompany,
                              items: documentAllCompanies.map(
                                (e) {
                                  String companyValue = e.get('companyName');
                                  return DropdownMenuItem(
                                      value: companyValue,
                                      child: Text(e.get('companyName')));
                                },
                              ).toList(),
                              isExpanded: true,
                              onTap: () {},
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedCompany = value;
                                  });
                                }
                              },
                              elevation: 4,
                            );
                          } else {
                            return Transform.scale(
                              scale: 5,
                              child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffffcc33), width: 1),
                      color: const Color(0xffffcc33),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    //margin : const EdgeInsets.only(left: 50),
                    child: MaterialButton(
                      //زر لتاكيد انشاء الطلب

                      onPressed: () async {
                        await initConnectivity();
                        if (determineTheInternetConnection == false) {
                          showsnakbar(
                              Context: context,
                              massage: 'غير متصل بالانترنت حاليا',
                              error: true);
                        } else {
                          if (determineTheInternetConnection == true) {
                            await performCreateOrder();
                          }
                        }
                      },

                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ]),
              )
            ])));
  }

  modalBottomSheetToTrackingNumber(
      {required String number, required BuildContext context}) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    double landscapes = landscape;
    double portraits = portrait;
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
            height: landscapes * 0.557,
            child: Padding(
              padding: EdgeInsets.only(top: landscapes * 0.103),
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: portraits * 0.341, right: portraits * 0.34),
                  width: landscapes * 14.7,
                  height: portraits * 0.32,
                  decoration: const BoxDecoration(
                    color: Color(0xffffcc33),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: landscapes * 0.032, bottom: landscapes * 0.041),
                      child: Image.asset('images/BeeLogo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.23,
                      left: portraits * 0.206,
                      right: portraits * 0.156),
                  child: const Text(
                    'الرقم التتبعي هو' + ' ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.237,
                      left: portraits * 0.206,
                      right: portraits * 0.446),
                  child: Text(
                    number,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.23, right: portraits * 0.706),
                  child: GestureDetector(
                      child: const Icon(Icons.copy,
                          color: Color(0xffffcc33), size: 32),
                      onTap: () async {
                        _copyText(number);
                        widget.orders == null
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(context, '/SendShopOrders');
                      }),
                ),
              ]),
            ),
          );
        });
  }

  void _copyText(String text) {
    FlutterClipboard.copy(trackingNumber!).then((value) {
      showsnakbar(Context: context, massage: 'Text copied');
    });
  }

  Future<void> performCreateOrder() async {
    if (checkData() && checkMobile()) {
      setState(() {
        trackingNumber = randomNumeric(10);
      });
      await createOrder();
      clear();
      modalBottomSheetToTrackingNumber(
          context: context, number: trackingNumber!);
    }
  }

  bool checkMobile() {
    bool statusStart =
        _mobileController.text[0] + _mobileController.text[1] == '59';
    bool statusNumberOfDigits = _mobileController.text.length == 9;
    bool status = statusStart && statusNumberOfDigits;
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

  bool checkData() {
    if (_firstNameController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _selectedCompany != null &&
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
      mobileError = _mobileController.text.isEmpty ? 'ادخل رقم الهاتف' : null;
      locationError = _locationController.text.isEmpty ? 'ادخل الوقع' : null;
      firstNameError =
          _firstNameController.text.isEmpty ? 'ادخل الاسم الاول' : null;
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

  Orders get orders {
    Orders order = widget.orders == null ? Orders() : widget.orders!;
    order.gmail = SharedPrefController().gmailShop;
    order.firstName = _firstNameController.text;
    order.deliveryCompany = _selectedCompany!;
    order.location = _locationController.text;
    order.mobile = _selectedNum! + _mobileController.text;
    order.trackingNumber = trackingNumber!;
    order.deliveryEmployeeName = 'لم يصل الطلب للموظف';
    order.orderStatus = 'جاهز للتسليم';
    order.latitude = latitude;
    order.longitude = longitude;
    return order;
  }

  void clear() {
    _firstNameController.text = '';
    _mobileController.text = '';
    _locationController.text = '';
    setState(() {
      latitude = 0;
      longitude = 0;
    });
  }

  Future<void> initConnectivity() async {
    /////////////////////////////////دوال فحص الاتصال بالانترنت
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

  Future<void> createOrder() async {
    bool status = widget.orders == null
        ? await FbFirestoreControllerOrders().crateOrders(orders: orders)
        : await FbFirestoreControllerOrders().updateOrders(orders: orders);
    if (status) {
      showsnakbar(
          Context: context,
          massage: status ? 'Process success' : 'Process failed',
          error: !status);
    }
  }
}
