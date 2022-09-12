import 'package:flutter/material.dart';

class DeliveryCompanyHome extends StatefulWidget {
  const DeliveryCompanyHome({Key? key}) : super(key: key);

  @override
  State<DeliveryCompanyHome> createState() => _DeliveryCompanyHomeState();
}

class _DeliveryCompanyHomeState extends State<DeliveryCompanyHome> {
  @override
  Widget build(BuildContext context) {
    final List<String> bnLabels = [
      'الطلبات الواردة',
      'إضافة موظف ',
      'الطلبات الراجعة',
      'الطلبات الخارجة لتسليم',
      'الموظفين',
      'الطلبات المسلّمة',
    ];
    const List<Icon> bnIcons = [
      Icon(Icons.move_to_inbox),
      Icon(Icons.add),
      Icon(Icons.keyboard_return),
      Icon(Icons.north_west),
      Icon(Icons.person),
      Icon(Icons.call_received),
    ];
    List<String> path = [
      '/OrderSendDeliveryManCompany',
      '/addMan',
      '/returnOrderCompany',
      '/OutForDeliveryCompany',
      '/allMenDelivery',
      '/receivedOrdersCompany',
    ];

    return Scaffold(
      body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 40.0),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 400,
                    height: 150,
                    child: const Image(
                      image: AssetImage(
                          'images/BeeLogo.png'),
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
                            Navigator.pushNamed(context, path[index]);
                          },
                          label: Text(
                            '${bnLabels[index]}',
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
                  child: Row(
                      children: [Expanded(
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
          )),
    );
  }
}
