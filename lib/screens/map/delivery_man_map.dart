import 'package:beedelivery/models/orders.dart';
import 'package:beedelivery/pref/shared_pref_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryManMap extends StatefulWidget {
  const DeliveryManMap({Key? key}) : super(key: key);

  @override
  State<DeliveryManMap> createState() => _DeliveryManMapState();
}

class _DeliveryManMapState extends State<DeliveryManMap> {
  late GoogleMapController _googleMapController;
  List<Orders> sendOrders = <Orders>[];
  final Set<Marker> _markers = <Marker>{};
  List<double> latitude = <double>[];
  List<double> longitude = <double>[];
  bool? determineTheInternetConnection;
  int nonRepetitionCounter = 0;

  orderMark() async{
    await FirebaseFirestore.instance.collection("sendOrderCompanies")
        .where("deliveryEmployeeName", isEqualTo: SharedPrefController().name)
        .where("deliveryCompany", isEqualTo: SharedPrefController().companyName)
        .get()
        .then((docs) {
      if (docs.docs.isNotEmpty) {

        for (int i = 0; i < docs.docs.length;i++) {
          latitude.add(docs.docs[i].get('latitude'));
          longitude.add(docs.docs[i].get('longitude'));
          var marker = Marker(
            markerId: MarkerId('marker_${_markers.length}'),
            visible: true,
            position: LatLng(docs.docs[i].get('latitude'),docs.docs[i].get('longitude')),

            infoWindow:  InfoWindow(
              title: docs.docs[i].get('firstName'),
              snippet:  docs.docs[i].get('mobile'),
            ),
          );
          setState(() {
            _markers.add(marker);
          });
        }
      }
    });
  }

  @override
  void initState() {
    orderMark();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme : IconThemeData(color: Colors.black),
        title: Text('الخريطة',  style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.black),),
        backgroundColor: Color(0xffffcc33),
      ),
      body: Stack(
        children: [
          // ordersMark(),
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(31.771959, 35.217018), zoom: 10),
            onMapCreated: (controller) {
              setState(() {
                _googleMapController = controller;
              });
            },
            markers: _markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onTap: (LatLng position) {},)
        ],
      ),
    );
  }
}
