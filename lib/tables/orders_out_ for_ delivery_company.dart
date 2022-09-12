import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/controllers/fb-fir-stor-send_orders_companies.dart';
import '/models/orders.dart';
import '/screens/basic/helper.dart';
import '/tables/order_descreption.dart';


//الطلبات الخارجة للتسليم لشركة التوصيل
class OutForDeliveryCompany extends StatefulWidget {
  const OutForDeliveryCompany({Key? key}) : super(key: key);

  @override
  _OutForDeliveryCompanyState createState() => _OutForDeliveryCompanyState();
}

class _OutForDeliveryCompanyState extends State<OutForDeliveryCompany>
    with Helper {
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
          'الطلبات الخارجة للتسليم',
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
          stream: FbFirestoreControllerSendOrdersCompanies()
              .readCustomSendOrdersCompaniesInformation(),
          builder: (context, snapshot) {
            //كود استدعاء الطلبات التي ارسلها المدير للموظف ليقراها ويراحعها
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentSendOrderCompany =
                  snapshot.data!.docs;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: documentSendOrderCompany.length,
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
                                                  companyOutDeliveryOrdersInformation(
                                                      documentSendOrderCompany[
                                                          index]))));
                                },
                                leading: const Icon(
                                    Icons.add_to_home_screen_outlined),
                                subtitle: Text(
                                  documentSendOrderCompany[index]
                                      .get('location'),
                                ),
                                title: Text(
                                  documentSendOrderCompany[index]
                                      .get('firstName'),
                                  style: const TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.bold,
                                      fontSize: (20),

                                      color: Colors.black),
                                ),
                                trailing: Text(
                                  documentSendOrderCompany[index]
                                      .get('orderStatus'),
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.bold,
                                      color: documentSendOrderCompany[index]
                                                  .get('orderStatus') ==
                                              'جاهز للتسليم'
                                          ? Colors.black
                                          : const Color(0xffffcc33)),
                                )),
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
                      'ًلا يوجد طلبات مرسلة حالياً',
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

  Orders companyOutDeliveryOrdersInformation(documentSnapshot) {
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
}
