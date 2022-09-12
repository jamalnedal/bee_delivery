import 'package:flutter/material.dart';
import '/models/orders.dart';
import '/screens/basic/helper.dart';

class OrderDescription extends StatefulWidget {
  const OrderDescription({Key? key, required this.orderDescription}) : super(key: key);
final Orders orderDescription;
  @override
  _OrderDescriptionState createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> with Helper {
  List<Orders> sendOrders = <Orders>[];
  bool download = false;
  int i = 0;
  String? firstName;
  String? mobile;
  String? deliveryCompany;
  String? location;
  String? trackingNumber;
  String? deliveryEmployeeName;
  String? orderStatus;
  double? latitude;
  double? longitude;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName=widget.orderDescription.firstName;
    mobile=widget.orderDescription.mobile;
    deliveryCompany=widget.orderDescription.deliveryCompany;
    location=widget.orderDescription.location;
    trackingNumber=widget.orderDescription.trackingNumber;
    deliveryEmployeeName=widget.orderDescription.deliveryEmployeeName;
    orderStatus=widget.orderDescription.orderStatus;
    latitude=widget.orderDescription.latitude;
    longitude=widget.orderDescription.longitude;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text(
            'تفاصيل الطلب',
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
        body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 40),
                child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 20.0,
                    shadowColor: const Color(0xFFF4E55AF),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20,right: 20),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                        const Text(
                        'تفاصيل الطلب',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                         const SizedBox(height: 50),
                         Container(
                           alignment: Alignment.topRight,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'اسم صاحب الطلب',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                firstName.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'رقم الهاتف',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                mobile.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),const SizedBox(height: 20),
                              const Text(
                                'موقع الطلب',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                location.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),const SizedBox(height: 20),
                              const Text(
                                'الشركة التابع لها',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                deliveryCompany.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),const SizedBox(height: 20),
                              const Text(
                                'الرقم التتبعي',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                trackingNumber.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),const SizedBox(height: 20),
                              const Text(
                                'الموظف المسؤول عن الطلب',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                deliveryEmployeeName.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),const SizedBox(height: 20),
                              const Text(
                                'حالة الطلب',
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),const SizedBox(height: 20),
                              Text(
                                orderStatus.toString(),
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    color: orderStatus.toString()=='جاهز للتسليم'?Colors.black:orderStatus.toString()=='خارج للتسليم'?Colors.yellow:
                                    orderStatus.toString()=='تم التسليم'?Colors.green:Colors.red
                              )),
                                const SizedBox(height: 20),
                        ]),
                         ),
                      ]),
                    ))),
            );
  }
}



