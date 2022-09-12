import 'package:flutter/material.dart';
import '../../tables/create_orders.dart';

class OnlineShopHome extends StatefulWidget {
  const OnlineShopHome({Key? key}) : super(key: key);

  @override
  State<OnlineShopHome> createState() => _OnlineShopHomeState();
}

class _OnlineShopHomeState extends State<OnlineShopHome> {
  @override
  Widget build(BuildContext context) {
    final List<String> bnLabels = [
      'إضافة طلب ',
      'الطلبات المرسلة',
      'الطلبات المسلّمة',
      'إرسال الطلبات',
      'الطلبات الخارجة للتسليم',
      'الطلبات الراجعة',
    ];
    const List<Icon> bnIcons = [
      Icon(Icons.add),
      Icon(Icons.move_to_inbox),
      Icon(Icons.call_received),
      Icon(Icons.send_to_mobile),
      Icon(Icons.north_west),
      Icon(Icons.keyboard_return),
    ];

    List<String> path = [
      '/onlineShop_delivered_orders',
      '/sendOrders',
      '/receivedOrdersShop',
      '/SendShopOrders',
      '/OutForDelivery',
      '/returnedOrdersShop',
    ];
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 0),
        height: double.infinity,
        child: ListView(shrinkWrap: true, children: [
          Column(
            children: [

              Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: 400,
                  height: 150,
                  child: const Image(
                    image: AssetImage('images/BeeLogo.png'),
                  )),
              SizedBox(
                height: 370,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 40,
                            crossAxisSpacing: 20,
                            childAspectRatio: 5 / 10),
                    itemBuilder: (context, index) {
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19.0)),
                        ),
                        onPressed: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateOrders(
                                        title: 'إنشاء طلب')));
                          } else {
                            Navigator.pushNamed(context, path[index]);
                          }
                        },
                        label: Text(
                          bnLabels[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),

                        icon: Icon(
                          bnIcons[index].icon,
                          size: 30,
                          color: const Color(0xffffcc33),
                        ),

                        //label text
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(19)),
                height: 200,
                child: Row(children: [
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset('images/poster.jpeg'),
                        Image.asset('images/poster2.jpeg'),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
