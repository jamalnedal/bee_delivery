import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/models/orders.dart';
import '/screens/basic/helper.dart';
import '/tables/order_descreption.dart';

import '../controllers/fb-fir-stor-returns-orders.dart';

//الطلبات الراجعة ـ شركة التوصيل
class ReturnOrderCompany extends StatefulWidget {
  const ReturnOrderCompany({Key? key}) : super(key: key);

  @override
  _ReturnOrderCompanyState createState() => _ReturnOrderCompanyState();
}

class _ReturnOrderCompanyState extends State<ReturnOrderCompany> with Helper {
  List<Orders> sendOrders = <Orders>[];

  @override
  Widget build(BuildContext context) {
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
          'الطلبات الراجعة',
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
          stream: FbFirestoreReturnsOrdersController()
              .readCustomerCompanyReturnedOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //كود الطلبات الراجعة للشركة من موظفيها
              return const Center(
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentReturnOrderCompany =
                  snapshot.data!.docs;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: documentReturnOrderCompany.length,
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
                                                companyReturnOrdersInformation(
                                                    documentReturnOrderCompany[
                                                        index]))));
                              },
                              leading: const Icon(Icons.keyboard_return),
                              subtitle: Text(
                                documentReturnOrderCompany[index]
                                    .get('location'),

                              ),
                              title: Text(
                                documentReturnOrderCompany[index]
                                    .get('firstName'),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: (20),

                                    color: Colors.black),
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      documentReturnOrderCompany[index]
                                          .get('deliveryEmployeeName'),
                                      style: const TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      documentReturnOrderCompany[index]
                                          .get('orderStatus'),
                                      style: const TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ]),
                            ),
                          )));
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/order.png'),
                    const Text(
                      'لا يوجد طلبات راجعة حالياً',
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

  Orders companyReturnOrdersInformation(documentSnapshot) {
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

// Note genaretNotre(QueryDocumentSnapshot documentSnapshot) {
//   Note note = Note();
//   note.id = documentSnapshot.id;
//   note.Title = documentSnapshot.get('title');
//   note.details = documentSnapshot.get('details');
//   return note;
// }
// Future<void> Delete({required String path})async{
//   bool status= await FbFirstorecontrooler().Delete(id: path);
//   String massege=status?'Delete Successfully':'fail successfully';
//   showsnakbar(Context: context, massage:massege,error: !status);
//
// }
}
