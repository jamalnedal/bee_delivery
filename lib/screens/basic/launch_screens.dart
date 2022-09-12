import 'dart:async';
import 'package:flutter/material.dart';
import '/pref/shared_pref_controller.dart';
import '../../controllers/fb_auth_controllers.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  late StreamSubscription streamSubscription;
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      streamSubscription= FbAuthControllers().listenToUserState(userStateCalback: (status) {
        String route= status?'/onlineShopHome_bn_screen':SharedPrefController().loginStatusMan==true?'/deliveryMan_bn_screen':SharedPrefController().loginStatueCompany?'/deliveryCompany_bn_screen'
            :'/environment_choices_screen';
        Navigator.pushReplacementNamed(context, route);
      },);
      //Navigator.pushReplacementNamed(context, '/environment_choices_screen');
    });
  }
  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.yellow.shade700,
            const  Color(0xffffcc33),
          ]),
        ),
        child:
            const Text(
              'Bee Delivery APP',
              style: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Aref Ruqaa'),
            ),

        )



    );
  }
}
