import 'package:flutter/material.dart';

class InnerEnvironmentChoicesScreen extends StatefulWidget {
  const InnerEnvironmentChoicesScreen({Key? key}) : super(key: key);

  @override
  State<InnerEnvironmentChoicesScreen> createState() =>
      _InnerEnvironmentChoicesScreenState();
}

class _InnerEnvironmentChoicesScreenState
    extends State<InnerEnvironmentChoicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xffffcc33),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(40.0),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                Navigator.pushReplacementNamed(context, '/online_login_screen');
              },

              child: const Text(
                'المتجر',
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
                    context, '/delivery_user_specify_screen');
              },

              child: const Text(
                'شركة التوصيل ',
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

              onPressed: () {},

              child: const Text(
                'تتبع طردي',
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
