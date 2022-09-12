import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/controllers/fb_fir_store_companies.dart';
import '/pref/shared_pref_controller.dart';
import '/screens/basic/helper.dart';

import '../controllers/fb-fir-stor-man-delivery.dart';

class AllMenDelivery extends StatefulWidget {
  const AllMenDelivery({Key? key}) : super(key: key);

  @override
  _AllMenDeliveryState createState() => _AllMenDeliveryState();
}

class _AllMenDeliveryState extends State<AllMenDelivery> with Helper {

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
          'الموظفين',
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
          stream: FbFirestoreControllerCompanies().readCustomerMenDelivery(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documentManDelivery = snapshot.data!.docs;
              //كود استدعاء الموظفين لكل مدير
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: documentManDelivery.length,
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
                              leading: const Icon(Icons.account_circle),
                              title: Text(
                                documentManDelivery[index].get('firstName'),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: (20),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),

                              subtitle: Text(
                                documentManDelivery[index].get('identificationNumber'),
                  //               style: const TextStyle(
                  //                   // fontFamily: 'Tajawal',
                  // //                                     // fontWeight: FontWeight.bold,
                  // //                                     // color: Colors.black),
                  //
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        String f =
                                        documentManDelivery[index].get('firstName');
                                        await SharedPrefController()
                                            .deliveryEmployeeName(
                                                deliveryEmployeeName: f);
                                       showsnakbar(Context: context, massage:'أضيف للمهمة');
                                      },
                                      icon: const Icon(Icons.add),
                                      color: const Color(0xffffcc33),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await deleteDeliveryMan(documentManDelivery[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: const Color(0xffffcc33),
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
                      'لا يوجد لديك موظفين حاليا ',
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


  Future<void> deleteDeliveryMan(String id) async {
    await FbFirestoreRegistrationMenController().deleteDeliveryMan(id: id);
  }

}
