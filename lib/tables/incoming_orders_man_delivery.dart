import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/fb-fir-stor-send_orders_companies.dart';
import '/controllers/fb-fir-store-delivered-orders.dart';
import '/models/orders.dart';
import '/screens/basic/helper.dart';
import '/tables/order_descreption.dart';
import '../controllers/fb-fir-stor-man-delivery.dart';
import '../controllers/fb-fir-stor-returns-orders.dart';

//الطلبات الواردة لموظف التوصيل
class IncomingOrdersManDelivery extends StatefulWidget {
  const IncomingOrdersManDelivery({Key? key}) : super(key: key);

  @override
  _IncomingOrdersManDeliveryState createState() =>
      _IncomingOrdersManDeliveryState();
}

class _IncomingOrdersManDeliveryState extends State<IncomingOrdersManDelivery>
    with Helper {
  List<Orders> sendOrders = <Orders>[];
  int nonRepetitionCounter = 0;
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
    double Landscape = landscape;
    double Portrait = portrait;
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
          'الطلبات الواردة للمراجعة',
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
          stream: FbFirestoreRegistrationMenController()
              .readCustomerOrdersManDelivery(),
          builder: (context, snapshot) {
            //كود استدعاء الطلبات للموظف المخصص صاحب الشركة المخصصة
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (determineTheInternetConnection == true &&
                snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentManDelivery =
                  snapshot.data!.docs;
              if (nonRepetitionCounter < 1) {
                for (QueryDocumentSnapshot v in documentManDelivery) {
                  Orders sendOrder = Orders();
                  sendOrder.id = v.id;
                  sendOrder.gmail = v.get('gmail');
                  sendOrder.firstName = v.get('firstName');
                  sendOrder.mobile = v.get('mobile');
                  sendOrder.trackingNumber = v.get('trackingNumber');
                  sendOrder.deliveryCompany = v.get('deliveryCompany');
                  sendOrder.location = v.get('location');
                  sendOrder.deliveryEmployeeName =
                      v.get('deliveryEmployeeName');
                  sendOrder.orderStatus = '';
                  sendOrder.latitude = v.get('latitude');
                  sendOrder.longitude = v.get('longitude');
                  sendOrders.add(sendOrder);
                }
                nonRepetitionCounter++;
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: documentManDelivery.length,
                itemBuilder: (context, index) {
                  initConnectivity();
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23, vertical: 20),
                      child: Material(
                          borderRadius: BorderRadius.circular(30),
                          elevation: 20.0,
                          shadowColor: const Color(0xFFF4E55AF),
                          child: Container(
                            height: 11  ,
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
                                                manOrdersInformation(
                                                    documentManDelivery[
                                                        index]))));
                              },
                              leading:
                                  const Icon(Icons.add_to_home_screen_outlined),
                              subtitle: Column(children: [
                                Text(
                                  documentManDelivery[index].get('mobile'),

                                ),
                                const SizedBox(height: 5),
                                Text(
                                  documentManDelivery[index].get('location'),
                                  // style: const TextStyle(
                                  //     fontFamily: 'Tajawal',
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.black),
                                ),
                              ]),
                              title: Text(
                                documentManDelivery[index].get('firstName'),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: (20),

                                    color: Colors.black),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 23),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          await initConnectivity();
                                          if (determineTheInternetConnection ==
                                              false) {
                                            showsnakbar(
                                                Context: context,
                                                massage:
                                                    'غير متصل بالانترنت حاليا',
                                                error: true);
                                          } else {
                                            if (determineTheInternetConnection ==
                                                true) {
                                              sendOrders[index].orderStatus =
                                                  'تم التسليم';
                                              await createDeliveredOrders(
                                                  sendOrders[index]);
                                              showsnakbar(
                                                  Context: context,
                                                  massage: 'تم تسليم الطلب');
                                              await deleteOrdersManDelivery(
                                                  sendOrders[index].id);
                                              deleteManOrdersDeliveryList(
                                                  sendOrders[index].id);

                                              //     showsnakbar(Context: context, massage: 'تم التسليم');
                                              // }},
                                            }
                                          }
                                        },
                                        child: const Text('تم',
                                            style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            await initConnectivity();
                                            if (determineTheInternetConnection ==
                                                false) {
                                              showsnakbar(
                                                  Context: context,
                                                  massage:
                                                      'غير متصل بالانترنت حاليا',
                                                  error: true);
                                            } else {
                                              if (determineTheInternetConnection ==
                                                  true) {
                                                sendOrders[index].orderStatus =
                                                    'تم الإرجاع';
                                                await createReturnsOrders(
                                                    sendOrders[index]);
                                                showsnakbar(
                                                    Context: context,
                                                    massage: 'تم ارجاع الطلب',
                                                    error: true);
                                                await deleteOrdersManDelivery(
                                                    sendOrders[index].id);
                                                deleteManOrdersDeliveryList(
                                                    sendOrders[index].id);
                                              }
                                            }
                                          },
                                          child: const Text('راجع',
                                              style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red))),
                                    ]),
                              ),
                            ),
                          )));
                },
              );
            } else if (determineTheInternetConnection == false) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/noInternet.png'),
                    const SizedBox(height: 20),
                    const Text(
                      'ًغير متصل بالانترنت حالياً',
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

  Orders manOrdersInformation(documentSnapshot) {
    Orders order = Orders();
    order.id = documentSnapshot.id;
    order.firstName = documentSnapshot.get('firstName');
    order.deliveryCompany = documentSnapshot.get('deliveryCompany');
    order.location = documentSnapshot.get('location');
    order.mobile = documentSnapshot.get('mobile');
    order.deliveryEmployeeName = documentSnapshot.get('deliveryEmployeeName');
    order.orderStatus = documentSnapshot.get('orderStatus');
    order.trackingNumber = documentSnapshot.get('trackingNumber');
    order.latitude=documentSnapshot.get('latitude');
    order.longitude=documentSnapshot.get('longitude');

    return order;
  }

  Future<void> createDeliveredOrders(Orders orders) async {
    //انشاء الطلبات المستلمة
    await FbFirestoreDeliveredOrdersController()
        .crateDeliveredOrders(orders: orders);
  }

  Future<void> deleteOrdersManDelivery(String id) async {
    await FbFirestoreControllerSendOrdersCompanies().deleteSendOrder(id: id);
  }

  Future<void> createReturnsOrders(Orders orders) async {
    //انشاء الطلبات الراجعة
    await FbFirestoreReturnsOrdersController()
        .crateReturnsOrders(orders: orders);
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

  bool deleteManOrdersDeliveryList(String id) {
    // contacts.removeWhere((element) => element.id == id);
    int index = sendOrders.indexWhere((element) => element.id == id);
    if (index != -1) {
      sendOrders.removeAt(index);
      return true;
    }
    return false;
  }
}
