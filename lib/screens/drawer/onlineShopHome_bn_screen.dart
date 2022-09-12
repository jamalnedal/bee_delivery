import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/pref/shared_pref_controller.dart';
import '/screens/onlineShop/onlineShopHome.dart';
import '../../controllers/fb_auth_controllers.dart';
import '../../models/bn_items.dart';

class OnlineShopHomeBnScreen extends StatefulWidget {
  const OnlineShopHomeBnScreen({Key? key}) : super(key: key);

  @override
  State<OnlineShopHomeBnScreen> createState() => _OnlineShopHomeBnScreenState();
}

class _OnlineShopHomeBnScreenState extends State<OnlineShopHomeBnScreen> {
  final int _currentIndex = 0;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot>streamShopOwnersStoreName;
  final List<BnItem> _bnItems = <BnItem>[
    BnItem(title: 'الرئيسية', widget: const OnlineShopHome()),
  ];

  @override
  void initState() {
    super.initState();
  streamShopOwnersStoreName=  _firebaseFirestore.collection("ShopOwners")
        .where("gmail", isEqualTo: SharedPrefController().gmailShop).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xffffcc33),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(_bnItems[_currentIndex].title,
            style: const TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color:  Color(0xffffcc33),
                  borderRadius: BorderRadius.only(
                      bottomRight:  Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              accountName: StreamBuilder<QuerySnapshot>(
                  stream:streamShopOwnersStoreName,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> documentStoreName =
                          snapshot.data!.docs;
                      return Text(documentStoreName[0].get('storeName'),
                          style: const TextStyle(
                              fontFamily: 'Tajwal',
                              fontWeight: FontWeight.bold,
                              color: Colors.black));
                    } else {
                      return Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),);
                    }
                  }),
              accountEmail: Text(
                  SharedPrefController().gmailShop,
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
                          'https://cdn.pixabay.com/photo/2018/01/29/17/01/woman-3116587_960_720.jpg'),
                    ))),),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xffffcc33)),
            title: const Text('الرئيسية'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: Color(0xffffcc33), size: 10),
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 500), () {
                // Navigator.pushNamed(context, '/onlineShop_bn_screen');
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xffffcc33)),
            title: const Text('تعديل الإعدادات'),
            subtitle: const Text('بروفايلي، معلومات الحساب'),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 10, color: Color(0xffffcc33)),
            onTap: () {
              Navigator.pushNamed(context, '/EditProfileShop');
            },
          ),
          Divider(
            indent: 0,
            endIndent: 40,
            color: Colors.grey.shade700,
            thickness: 0.8,
          ),
          ListTile(
              leading: const Icon(Icons.logout, color: Color(0xffffcc33)),
              title: const Text('تسجيل الخروج'),
              onTap: () async {
                await FbAuthControllers().signOut();
                await SharedPrefController().clear();
                Navigator.pushReplacementNamed(
                    context, '/environment_choices_screen');
                
                //SharedPrefController().clear();
                // Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/environment_choices_screen', (route) => false);
              }),
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
      //         icon: Icon(Icons.person), label: 'تبديل الحساب'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
      //   ],
      // ),
    );
  }
}
