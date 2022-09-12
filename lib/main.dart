import 'package:beedelivery/screens/map/delivery_man_map.dart';
import 'package:beedelivery/screens/orderStatus/order_status_screen.dart';
import 'package:beedelivery/screens/orderStatus/tracking_number.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '/screens/map/add_order_map.dart';
import '/pref/shared_pref_controller.dart';
import '/profile_companies/edit_profile-companies.dart';
import '/profile_shop/edit_profile_shop.dart';
import '/screens/DeliveryCompany/deliveryCompanyHome.dart';
import '/screens/DeliveryCompany/deliveryCompanyLogin.dart';
import '/screens/DeliveryCompany/deliveryCompanySignUp.dart';
import '/screens/DeliveryCompany/deliveryManHome.dart';
import '/screens/DeliveryCompany/deliveryManLogin.dart';
import '/screens/DeliveryCompany/delivery_user_specify.dart';
import '/screens/DeliveryCompany/forget_Password.dart';
import '/screens/basic/environmentChoices.dart';
import '/screens/basic/launch_screens.dart';
import '/screens/drawer/deliveryCompany_bn_screen.dart';
import '/screens/drawer/deliveryMan_bn_screen.dart';
import '/screens/drawer/onlineShopHome_bn_screen.dart';
import '/screens/onlineShop/OnlinesignUp.dart';
import '/screens/onlineShop/forget_password.dart';
import '/screens/onlineShop/onlineShopHome.dart';
import '/tables/add_delivery_man.dart';
import '/tables/delivery_orders_company.dart';
import '/tables/delivery_orders_man.dart';
import '/tables/delivery_orders_shop.dart';
import '/tables/incoming_orders_man_delivery.dart';
import '/tables/order_my_company_send_delivery_man.dart';
import '/tables/orders_out_%20for_%20delivery_company.dart';
import '/tables/orders_out_%20for_%20delivery_shop.dart';
import '/tables/ready%20_for_delivery_order_shop.dart';
import '/tables/return_orders_company.dart';
import '/tables/return_orders_man.dart';
import '/tables/return_orders_shop.dart';
import '/tables/send_shop_orders.dart';
import '/tables/the-all-men-delivery.dart';
import 'screens/onlineShop/onlineLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  await Firebase.initializeApp();
  runApp(const BeeDelivery());
}

class BeeDelivery extends StatelessWidget {
  const BeeDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xffffcc33),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Obtain the current media query information.
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
            // Set the default textScaleFactor to 1.0 for
            // the whole subtree.
            data: mediaQueryData.copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      supportedLocales: const [
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/online_login_screen': (context) => const OnlineLoginScreen(),
        '/onlineShop_home': (context) => const OnlineShopHome(),
        '/forget-password': (context) => const ForgetPassword(),
        '/environment_choices_screen': (context) =>
            const EnvironmentChoicesScreen(),
        '/deliveryCompany_login_screen': (context) =>
            const DeliveryCompanyLoginScreen(),
        '/deliveryMan_login_screen': (context) =>
            const DeliveryManLoginScreen(),
        '/delivery_user_specify_screen': (context) =>
            const DeliveryUserSpecifyScreen(),
        '/onlineShop_signup': (context) => const OnlineShopSignUp(),
        '/deliveryCompany_bn_screen': (context) =>
            const DeliveryCompanyBnScreen(),
        '/deliveryMan_bn_screen': (context) => const DeliveryManBnScreen(),
        '/deliveryMan_home': (context) => const DeliveryManHome(),
        '/deliveryCompany_signUp': (context) => const DeliveryCompanySignUp(),
        '/deliveryCompany_home': (context) => const DeliveryCompanyHome(),
        '/onlineShopHome_bn_screen': (context) =>
            const OnlineShopHomeBnScreen(),
        '/sendOrders': (context) => const ReadForDeliveryOrderShop(),
        '/SendShopOrders': (context) => const SendShopOrders(),
        '/EditProfileShop': (context) => const EditProfileShop(),
        '/OrderSendDeliveryManCompany': (context) =>
            const OrderSendDeliveryManCompany(),
        '/OutForDelivery': (context) => const OutForDelivery(),
        '/OutForDeliveryCompany': (context) => const OutForDeliveryCompany(),
        '/editProfileCompany': (context) => const EditProfileCompany(),
        '/addMan': (context) => const AddDeliveryMan(),
        '/allMenDelivery': (context) => const AllMenDelivery(),
        '/IncomingOrdersManDelivery': (context) =>
            const IncomingOrdersManDelivery(),
        '/DeliveryOrdersMan': (context) => const DeliveryOrdersMan(),
        '/ReturnOrderMan': (context) => const ReturnOrderMan(),
        '/receivedOrdersShop': (context) => const DeliveryOrdersShop(),
        '/returnedOrdersShop': (context) => const ReturnedOrdersShop(),
        '/receivedOrdersCompany': (context) => const DeliveryOrdersCompany(),
        '/returnOrderCompany': (context) => const ReturnOrderCompany(),
        '/ForgetPasswordCompany': (context) => const ForgetPasswordCompany(),
        '/add_order_map': (context) => const AddOrderMap(),
        '/delivery_man_map': (context) => const DeliveryManMap(),
        '/order_status_screen': (context) =>  OrderStatusScreen(),
        '/tracking_number': (context) => const TrackingNumber()
      },
    );
  }
}
