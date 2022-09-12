import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_stepper/status_stepper.dart';

import '../../pref/shared_pref_controller.dart';

class OrderStatusScreen extends StatelessWidget {
  OrderStatusScreen({Key? key}) : super(key: key);
  String statusMassage = '';
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      Map<String, dynamic> map =
          modalRoute.settings.arguments as Map<String, dynamic>;
      if (map.containsKey('status')) {
        statusMassage = map['status'];
        curIndex = map['curIndex'];
      }
    }
    final statuses = List.generate(
      4,
      (index) => SizedBox.square(
        dimension: 32,
        child: Center(
            child: Text(
          '$index',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
    int lastIndex = -1;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade100,
          child: const Icon(Icons.question_mark_outlined, size: 50,color: Colors.amber, shadows: [ Shadow(offset: Offset.zero)],),
          onPressed: () {
    modalBottomSheetToTrackingNumber(context: context);

          }),

      //

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'حالة الطلب',
          style: TextStyle(
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: const Color(0xffffcc33),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                statusMassage,
                style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StatusStepper(
                connectorCurve: Curves.easeIn,
                itemCurve: Curves.easeOut,
                activeColor: Colors.amber,
                disabledColor: Colors.black,
                animationDuration: const Duration(milliseconds: 500),
                lastActiveIndex: lastIndex,
                currentIndex: curIndex,
                connectorThickness: 6,
                children: statuses,
              ),
            ),
          ],
        ),
      ),
    );

  }
  modalBottomSheetToTrackingNumber(
      {
         required BuildContext context}) {
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
              padding: EdgeInsets.only(top: landscapes * 0.042),
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
                      child:
                      Image.asset('images/BeeLogo.png')),

                ),

               const  Padding(
                  padding: EdgeInsets.only(top: 160, right: 150),
                  child: Text('تعليمات التتبع ',textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal'),),),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.29,
                      left: portraits * 0.206,
                      right: portraits * 0.156),
                  child: const Text(
                    '0 : قيد التنفيذ - المتجر',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.33,
                      left: portraits * 0.206,
                      right: portraits * 0.156),
                  child: const Text(
                    '1 : قيد التنفيذ - شركة التوصيل',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.37,
                      left: portraits * 0.206,
                      right: portraits * 0.156),
                  child: const Text(
                    '2 : خارج للتسليم',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscapes * 0.41,
                      left: portraits * 0.206,
                      right: portraits * 0.156),
                  child: const Text(
                    '3 : تم التسليم',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal'),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
