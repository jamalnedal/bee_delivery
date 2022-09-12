import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb_fir_stor_send_orders.dart';
import '/models/orders.dart';
import '/pref/shared_pref_controller.dart';
import '/screens/basic/helper.dart';
import '../controllers/fb-fir-stor-send_orders_companies.dart';
import '../models/city.dart';
import 'order_descreption.dart';

//ملف الطلبات الواردة لشركة التوصيل
class OrderSendDeliveryManCompany extends StatefulWidget {
  const OrderSendDeliveryManCompany({Key? key}) : super(key: key);

  @override
  _OrderSendDeliveryManCompanyState createState() =>
      _OrderSendDeliveryManCompanyState();
}

class _OrderSendDeliveryManCompanyState
    extends State<OrderSendDeliveryManCompany> with Helper {
  List<Orders> sendOrderCompanyList = <Orders>[];
  bool download = false;
  int nonRepetitionCounter = 0;
  int sendOrderCompanyListLeangth = 0;
  bool? determineTheInternetConnection;

  @override
  void initState() {
    setState(() {});
    // TODO: implement initState
    super.initState();
    initConnectivity();
  }

  final List<City> _city = <City>[
    City(id: 1, name: 'طولكرم'),
    City(id: 2, name: 'الخليل'),
    City(id: 3, name: 'نابلس'),
    City(id: 4, name: 'أريحا'),
    City(id: 5, name: 'بيت لحم'),
    City(id: 6, name: 'القدس'),
  ];

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    return Scaffold(
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
          ' الطلبات الواردة',
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FbFirestoreControllerSendOrders().readCustomCompanies(),
          //كود لقرائة جميع الطلبات المخصصة من المتاجر لشركة معينة
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (determineTheInternetConnection == true &&
                snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentCompanySendDelivery =
                  snapshot.data!.docs;
              if (nonRepetitionCounter < 1) {
                for (QueryDocumentSnapshot v in documentCompanySendDelivery) {
                  sendOrderCompanyList.add(sendOrdersToDelivery(v));
                  sendOrderCompanyListLeangth = sendOrderCompanyList.length;
                }
                nonRepetitionCounter++; //لمنع تكرار العناصر في المصفوفة بسبب الفور لوب
              }
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: documentCompanySendDelivery.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 20),
                          child: Material(
                              borderRadius: BorderRadius.circular(30),
                              elevation: 20.0,
                              shadowColor: const Color(0xFFF4E55AF),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderDescription(
                                                orderDescription:
                                                    sendOrdersToDelivery(
                                                        documentCompanySendDelivery[
                                                            index]))));
                                  },
                                  leading: const Icon(
                                      Icons.add_to_home_screen_outlined),
                                  subtitle: Text(
                                      documentCompanySendDelivery[index]
                                          .get('location')),
                                  title: Text(
                                    documentCompanySendDelivery[index]
                                        .get('firstName'),
                                    style: const TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontSize: (20),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await deleteOrdersToDeliveryFromCollection(
                                          path:
                                              documentCompanySendDelivery[index]
                                                  .id);
                                      deleteOrdersToDeliveryFromList(
                                          sendOrderCompanyList[index].id);
                                      setState(() {
                                        sendOrderCompanyListLeangth =
                                            sendOrderCompanyListLeangth -
                                                1; //تحديث لحالة الحذف
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: const Color(0xffffcc33),
                                  ),
                                ),
                              )));
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'المجموع',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          const Spacer(),
                          Chip(
                            label: Text(
                              sendOrderCompanyListLeangth.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            backgroundColor: const Color(0xffffcc33),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: portrait * 0.393,
                            height: landscape * 0.064,
                            decoration: BoxDecoration(
                              color: const Color(0xffffcc33),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await initConnectivity();
                                if (determineTheInternetConnection == false) {
                                  showsnakbar(
                                      Context: context,
                                      massage: 'غير متصل بالانترنت حاليا',
                                      error: true);
                                } else {
                                  if (determineTheInternetConnection == true) {
                                    if (SharedPrefController()
                                            .deliveryEmployeeNames !=
                                        '') {
                                      setState(() {
                                        download = true; //لبدء تحميل العملية
                                      });
                                      for (Orders v in sendOrderCompanyList) {
                                        await createSendOrdersForDelivery(v);
                                        await updatedOrderToOutDelivery(v);
                                        await deleteOrdersToDeliveryFromCollection(
                                            path: v.id);
                                      }
                                      Navigator.pushNamed(context,
                                          '/deliveryCompany_bn_screen');
                                    } else {
                                      showsnakbar(
                                          Context: context,
                                          massage:
                                              'حدد مهمة للمدير من قائمة المدراء');
                                    }
                                    setState(() {
                                      download = false; //لانتهاء تحميل العملية
                                    });

                                    Future.delayed(
                                        const Duration(seconds: 60000), () {});
                                  }
                                }
                              },
                              child: const Text(
                                'إرسال الطلبات للموظف',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          download
                              ? const CircularProgressIndicator()
                              : const Text(''),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
            } else {
              if (determineTheInternetConnection == false) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/noInternet.png'),
                      const SizedBox(height: 20),
                      const Text(
                        'غير متصل بالانترنت حاليا',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/order.png'),
                      const Text(
                        'لا يوجد طلبات حالياً للارسال',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }

  Future<void> createSendOrdersForDelivery(Orders sendOrderCompany) async {
    await FbFirestoreControllerSendOrdersCompanies()
        .crateSendOrder(sendOrderCompany: sendOrderCompany);
  }

  Orders sendOrdersToDelivery(QueryDocumentSnapshot documentSnapshot) {
    Orders order = Orders();
    order.id = documentSnapshot.id;
    order.mobile = documentSnapshot.get('mobile');
    order.firstName = documentSnapshot.get('firstName');
    order.gmail = documentSnapshot.get('gmail');
    order.location = documentSnapshot.get('location');
    order.deliveryEmployeeName =
        SharedPrefController().deliveryEmployeeNames == ''
            ? 'لم يصل الطلب للموظف'
            : SharedPrefController().deliveryEmployeeNames;
    order.trackingNumber = documentSnapshot.get('trackingNumber');
    order.deliveryCompany = documentSnapshot.get('deliveryCompany');
    order.orderStatus = 'خارج للتسليم';
    order.latitude = documentSnapshot.get('latitude');
    order.longitude = documentSnapshot.get('longitude');
    return (order);
  }

  Future<void> deleteOrdersToDeliveryFromCollection(
      {required String path}) async {
    await FbFirestoreControllerSendOrders().deleteSendOrder(id: path);
  }

  Future<void> updatedOrderToOutDelivery(Orders orders) async {
    //تعديل الطلب المرسل للمدير بعد ان يرسله للموظف ليصبح خارج للتسليم
    await FbFirestoreControllerSendOrders().updateSendOrder(orders: orders);
  }

  bool deleteOrdersToDeliveryFromList(String id) {
    // contacts.removeWhere((element) => element.id == id);
    int index = sendOrderCompanyList.indexWhere((element) => element.id == id);
    if (index != -1) {
      sendOrderCompanyList.removeAt(index);
      return true;
    }
    return false;
  }

  Future<void> initConnectivity() async {
    //التحقق من الانترنت
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
