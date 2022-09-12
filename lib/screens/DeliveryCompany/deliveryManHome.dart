import 'package:flutter/material.dart';

class DeliveryManHome extends StatefulWidget {
  const DeliveryManHome({Key? key}) : super(key: key);

  @override
  State<DeliveryManHome> createState() => _DeliveryManHomeState();
}

class _DeliveryManHomeState extends State<DeliveryManHome> {
  @override
  Widget build(BuildContext context) {
    final List<String> bnLabels = [
      'خريطة الطلبات',
      'الطلبات الراجعة',
      'الطلبات الواردة',
      'الطلبات المسلمة',
    ];
    const List<Icon> bnIcons = [
      Icon(Icons.move_to_inbox),
      Icon(Icons.keyboard_return),
      Icon(Icons.location_pin),
      Icon(Icons.send_to_mobile),
    ];
    List<String> path = [
      '/delivery_man_map',
      '/ReturnOrderMan',
      '/IncomingOrdersManDelivery',
      '/DeliveryOrdersMan',

    ];
    return Scaffold(
      body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 70.0),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [


                Container(
                    padding: const EdgeInsets.only(top: 10),
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
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 40,
                              crossAxisSpacing: 20,
                              childAspectRatio: 8/10),
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
                  child: Row(
                      children: [Expanded(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Image.asset('images/poster.jpeg'),
                            Image.asset('images/poster2.jpeg'),
                            Image.asset('images/poster3.jpeg'),

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
