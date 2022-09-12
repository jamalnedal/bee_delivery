import 'package:beedelivery/screens/basic/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackingNumber extends StatefulWidget {
  const TrackingNumber({Key? key}) : super(key: key);

  @override
  State<TrackingNumber> createState() => _TrackingNumberState();
}

class _TrackingNumberState extends State<TrackingNumber> with Helper {
  late TextEditingController _trackNumTextController;
  bool? determineTheInternetConnection;
  String orderStatus = '';
  bool find = false;
  int curIndex = 0;

  Future findOrderByTrackingNumber() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((document) {
      for (int i = 0; i < document.docs.length; i++) {
        if (document.docs[i].get('trackingNumber') ==
            _trackNumTextController.text) {
          setState(() {
            orderStatus = 'طلبك جاهز للارسال';
            find = true;
            curIndex = 0;
          });
          break;
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('sendOrder')
        .get()
        .then((document) {
      for (int i = 0; i < document.docs.length; i++) {
        if (document.docs[i].get('trackingNumber') ==
            _trackNumTextController.text) {
          setState(() {
            orderStatus = 'طلبك جاهز للخروج على الطريق';
            find = true;
            curIndex = 1;
          });
          break;
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('sendOrderCompanies')
        .get()
        .then((document) {
      for (int i = 0; i < document.docs.length; i++) {
        if (document.docs[i].get('trackingNumber') ==
            _trackNumTextController.text) {
          setState(() {
            orderStatus = 'طلبك خارج للتسليم';
            find = true;
            curIndex = 2;
          });
          break;
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('deliveredOrders')
        .get()
        .then((document) {
      for (int i = 0; i < document.docs.length; i++) {
        if (document.docs[i].get('trackingNumber') ==
            _trackNumTextController.text) {
          setState(() {
            orderStatus = 'تم تسليم الطلب';
            find = true;
            curIndex = 3;
          });
          break;
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('returnsOrders')
        .get()
        .then((document) {
      for (int i = 0; i < document.docs.length; i++) {
        if (document.docs[i].get('trackingNumber') ==
            _trackNumTextController.text) {
          setState(() {
            orderStatus = 'تم الارجاع';
          });
          break;
        }
      }
    });
    if (orderStatus == '' &&
        _trackNumTextController.text.isEmpty &&
        find == false) {
      showsnakbar(
          Context: context,
          massage: 'الرقم التتبعي غير صحيح،حاول مرة أخرى',
          error: true);
    } else if (orderStatus == 'تم الارجاع') {
      showsnakbar(Context: context, massage: 'تم ارجاع طلبك', error: true);
    } else {
      await Navigator.pushNamed(context, '/order_status_screen',
          arguments: {'status': orderStatus, 'curIndex': curIndex});
    }
  }

  @override
  void initState() {
    super.initState();
    _trackNumTextController = TextEditingController();
  }

  @override
  void dispose() {
    _trackNumTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('تتبع طردي',
            style: TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: Color(0xffffcc33),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _trackNumTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: const Text(
                  'الرقم التتبعي الخاص بك',
                  style: TextStyle(color: Colors.black, fontFamily: 'Tajawal'),
                ),
                counterText: '',
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
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffffcc33), width: 1),
                color: const Color(0xffffcc33),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30),
              ),

              //margin : const EdgeInsets.only(left: 50),
              child: MaterialButton(
                //زر لتاكيد تسجيل الدخول

                onPressed: () async {
                  // await initConnectivity();
                  // if (determineTheInternetConnection == false) {
                  //   showsnakbar(
                  //       Context: context,
                  //       massage: 'غير متصل بالانترنت حاليا',
                  //       error: true);
                  // }
                  findOrderByTrackingNumber();
                },

                child: const Text(
                  'تتبع طردي',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
