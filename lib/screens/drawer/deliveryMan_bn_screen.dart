import 'package:flutter/material.dart';
import '/pref/shared_pref_controller.dart';
import '../../models/bn_items.dart';
import '../DeliveryCompany/deliveryManHome.dart';

class DeliveryManBnScreen extends StatefulWidget {
  const DeliveryManBnScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryManBnScreen> createState() => _DeliveryManBnScreenState();
}

class _DeliveryManBnScreenState extends State<DeliveryManBnScreen> {
  final int _currentIndex = 0;
  final List<BnItem> _bnItems = <BnItem>[
    BnItem(title: 'الرئيسية', widget: const DeliveryManHome()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xffffcc33),

        // backgroundColor: Colors.transparent,
        // elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(_bnItems[_currentIndex].title,
            style: const TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade100,
        child: ListView(children: [
          UserAccountsDrawerHeader(
            decoration:const BoxDecoration(
                color:  Color(0xffffcc33),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            accountName: Text(SharedPrefController().name,
                style: const TextStyle(
                    fontFamily: 'Tajwal',
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            accountEmail: Text(SharedPrefController().identificationNumberMan,
                style: const TextStyle(
                    fontFamily: 'Aref Ruqaa',
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            currentAccountPicture: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1))
                    ],
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://media.istockphoto.com/photos/handsome-young-man-picture-id618033536?k=20&m=618033536&s=612x612&w=0&h=krAiFm5Q3bcDXZ0EkiF1CWnWG28Fpc2JI2hT-_B3Umk=')
                    ))),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xffffcc33)),
            title: const Text('الرئيسية'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xffffcc33)),
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 500), () {
                // Navigator.pushNamed(context, '/onlineShop_bn_screen');
              });
            },
          ),
          //ListTile(
            //leading: const Icon(Icons.info, color: Color(0xffffcc33)),
            //title: const Text('تعديل الإعدادات'),
           // subtitle: const Text('بروفايلي، معلومات الحساب'),
    //         trailing: const Icon(
    //           Icons.arrow_forward_ios,
    //           size: 10, color: Color(0xffffcc33)
    //         ),
    //         onTap: () {
    // Navigator.pushNamed(context, '/editProfileMan');
    //
    //         },

          Divider(
            indent: 0,
            endIndent: 40,
            color: Colors.grey.shade700,
            thickness: 0.8,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xffffcc33)),
            title: const Text('تسجيل الخروج'),
            onTap: ()async {
              await SharedPrefController().clear();
              Navigator.pushReplacementNamed(
                  context, '/environment_choices_screen');
            },
          ),
        ]),
      ),
      body: _bnItems[_currentIndex].widget,
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.black,
      //   selectedIconTheme: const IconThemeData(color: Colors.black),
      //   unselectedItemColor: Colors.grey.shade400,
      //   unselectedIconTheme: const IconThemeData(color: Colors.grey),
      //   elevation: 0,
      //   backgroundColor: Colors.yellow.shade500,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (int value) {
      //     setState(() {
      //       _currentIndex = value;
      //     });
      //   },
      //   currentIndex: _currentIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outlined),
      //         label: 'تبديل الحساب',
      //         activeIcon: Icon(Icons.person)),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home_outlined),
      //         label: 'الرئيسية',
      //         activeIcon: Icon(Icons.home)),
      //   ],
      // ),
    );
  }
}
