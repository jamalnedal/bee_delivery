import 'package:flutter/material.dart';

class EnvironmentChoicesScreen extends StatefulWidget {
  const EnvironmentChoicesScreen({Key? key}) : super(key: key);

  @override
  State<EnvironmentChoicesScreen> createState() =>
      _EnvironmentChoicesScreenState();
}

class _EnvironmentChoicesScreenState extends State<EnvironmentChoicesScreen> {
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
          padding: const EdgeInsets.all(20.0),
          height: double.infinity,
          child: ListView(shrinkWrap: true, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  // بوكس بارتفاع معين ليعطيني مساحه بين العناصر
                  height: 80.0,
                ),
                Container(
                    width: 400,
                    height: 200,
                    child: const Image(
                      image: AssetImage('images/BeeLogo.png'),
                    )),
                const SizedBox(
                  height: 70,
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
                      Navigator.pushNamed(context, '/online_login_screen');
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
                      Navigator.pushNamed(
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
                    color: const Color(0xff1A1C20),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  //margin : const EdgeInsets.only(left: 50),
                  child: MaterialButton(
                    //زر لتاكيد تسجيل الدخول

                    onPressed: () {
                      Navigator.pushNamed(context, '/tracking_number');
                    },

                    child: const Text(
                      'تتبع طردي',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
