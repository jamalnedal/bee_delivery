import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb_fir_stor_send_orders.dart';
import '/controllers/fb_fir_store_orders.dart';
import '/models/orders.dart';
import '/screens/basic/helper.dart';
import 'create_orders.dart';

//ارسال الطلبات
class SendShopOrders extends StatefulWidget {
  const SendShopOrders({Key? key}) : super(key: key);

  @override
  _SendShopOrdersState createState() => _SendShopOrdersState();
}

class _SendShopOrdersState extends State<SendShopOrders> with Helper {
  List<Orders> sendOrders = <Orders>[];
  bool downloadButtonSendOrder = false;
  int nonRepetitionCounter =
      0; //عداد لعدم تكرار العناصر في المصفوفة التي بداخل الفور لوب
  int sendOrdersListLength = 0;
  bool? determineTheInternetConnection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();
  }

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
          'الطلبات',
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
          stream:
              FbFirestoreControllerOrders().readCustomShopOrdersInformation(),
          //دالة استدعاء الطلبات  في المتجر
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (determineTheInternetConnection == true &&
                snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentOrderShop =
                  snapshot.data!.docs;
              //كود استدعاء للطلبات المنشئة من قبل صاحب المتجر
              //v مؤشر لجميع القرائات في التطبيق
              if (nonRepetitionCounter < 1) {
                for (QueryDocumentSnapshot v in documentOrderShop) {
                  Orders sendOrder = Orders();
                  sendOrder.id = v.id;
                  sendOrder.gmail = v.get('gmail');
                  sendOrder.firstName = v.get('firstName');
                  sendOrder.latitude = v.get('latitude');
                  sendOrder.longitude = v.get('longitude');
                  sendOrder.mobile = v.get('mobile');
                  sendOrder.trackingNumber = v.get('trackingNumber');
                  sendOrder.deliveryCompany = v.get('deliveryCompany');
                  sendOrder.location = v.get('location');
                  sendOrder.deliveryEmployeeName =
                      v.get('deliveryEmployeeName');
                  sendOrder.orderStatus = v.get('orderStatus');

                  sendOrders.add(sendOrder);
                }
                sendOrdersListLength = sendOrders.length;
                nonRepetitionCounter++;
              }
              return Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: documentOrderShop.length,
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
                                            builder: (context) => CreateOrders(
                                                orders: shopOrdersInformation(
                                                    documentOrderShop[index]),
                                                title: 'تعديل طلب')));
                                  },
                                  leading: const Icon(
                                      Icons.add_to_home_screen_outlined),
                                  subtitle: Text(
                                    documentOrderShop[index].get('location'),
                                    style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                  title: Text(
                                    documentOrderShop[index].get('firstName'),
                                    style: const TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.bold,
                                        fontSize: (20),
                                        color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await deleteShopOrders(
                                          path: documentOrderShop[index].id);
                                      deleteShopOrdersList(
                                          sendOrders[index].id);
                                      setState(() {
                                        sendOrdersListLength =
                                            sendOrdersListLength - 1;
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
                              sendOrdersListLength.toString(),
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
                                      massage: 'ًغير متصل بالانترنت حالياً',
                                      error: true);
                                } else {
                                  if (determineTheInternetConnection == true) {
                                    setState(() {
                                      downloadButtonSendOrder = true;
                                    });
                                    for (Orders v in sendOrders) {
                                      await createShopSendOrders(v);
                                      await deleteShopOrders(path: v.id);
                                    }
                                    Navigator.pushNamed(
                                        context, '/onlineShopHome_bn_screen');
                                    setState(() {
                                      downloadButtonSendOrder = false;
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                'إرسال الطلبات',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          downloadButtonSendOrder
                              ? const CircularProgressIndicator()
                              : const Text(''),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
            } else if (determineTheInternetConnection == false) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/noInternet.png'),
                    const SizedBox(height: 20),
                    const Text(
                      'ًًًغير متصل بالانترنت حالياً',
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
          }),
    );
  }

  Future<void> createShopSendOrders(Orders orders) async {
    await FbFirestoreControllerSendOrders().crateSendOrder(orders: orders);
  }

  Orders shopOrdersInformation(QueryDocumentSnapshot documentSnapshot) {
    Orders order = Orders();
    order.id = documentSnapshot.id;
    order.mobile = documentSnapshot.get('mobile');
    order.firstName = documentSnapshot.get('firstName');
    order.gmail = documentSnapshot.get('gmail');
    order.location = documentSnapshot.get('location');
    order.deliveryEmployeeName = documentSnapshot.get('deliveryEmployeeName');
    order.trackingNumber = documentSnapshot.get('trackingNumber');
    order.deliveryCompany = documentSnapshot.get('deliveryCompany');
    order.orderStatus = documentSnapshot.get('orderStatus');
    order.latitude = documentSnapshot.get('latitude');
    order.longitude = documentSnapshot.get('longitude');
    return order;
  }

  Future<void> deleteShopOrders({required String path}) async {
    await FbFirestoreControllerOrders().deleteOrders(id: path);
  }

  bool deleteShopOrdersList(String id) {
    // contacts.removeWhere((element) => element.id == id);
    int index = sendOrders.indexWhere((element) => element.id == id);
    if (index != -1) {
      sendOrders.removeAt(index);
      return true;
    }
    return false;
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
}
