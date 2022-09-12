import 'package:flutter/material.dart';

class DeliveryUserSpecifyScreen extends StatefulWidget {
  const DeliveryUserSpecifyScreen({Key? key}) : super(key: key);

  @override
  _DeliveryUserSpecifyScreen createState() => _DeliveryUserSpecifyScreen();
}

class _DeliveryUserSpecifyScreen extends State<DeliveryUserSpecifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Bee Delivery',
            style: TextStyle(
                fontFamily: 'Aref Ruqaa',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, "/environment_choices_screen");
              }),
          //عنوان الاب بار
          centerTitle: true,
          // سنترنا العنوان
          backgroundColor: Colors.transparent,
          // لون خلفيه الاب بار
          //shadowColor: Colors.black,
          // لحتى يتواجد ظل اسود تحت الاب بار
          elevation: 0, // درجة الظل
        ),
        body: Container(

          color: const Color(0xffffcc33),
         alignment: Alignment.center,

          padding: const EdgeInsets.all(40.0),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
              Container(
                // color: Colors.yellow.shade500,
                height: 40.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: const Color(0xffffcc33),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                ),
                //margin : const EdgeInsets.only(left: 50),
                child: MaterialButton(
                  //زر لتاكيد تسجيل الدخول

                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/deliveryCompany_login_screen');
                  },

                  child: const Text(
                    'المدير',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                // color: Colors.yellow.shade500,
                height: 40.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: const Color(0xffffcc33),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                ),
                //margin : const EdgeInsets.only(left: 50),
                child: MaterialButton(
                  //زر لتاكيد تسجيل الدخول

                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/deliveryMan_login_screen');
                  },

                  child: const Text(
                    'موظف التوصيل ',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
