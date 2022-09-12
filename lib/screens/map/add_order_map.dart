import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AddOrderMap extends StatefulWidget {
  const AddOrderMap({Key? key}) : super(key: key);

  @override
  State<AddOrderMap> createState() => _AddOrderMapState();
}

class _AddOrderMapState extends State<AddOrderMap> {
  final CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(31.771959, 35.217018), zoom: 16);
  late GoogleMapController _googleMapController;
  final Set<Marker> _markers = <Marker>{};
  final Set<Circle> _circles = <Circle>{};
  double latitude = 0;
  double longitude = 0;

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
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: (controller) {
          setState(() {
            _googleMapController = controller;
          });
        },
        markers: _markers,
        circles: _circles,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onTap: (LatLng position) {
          var marker = Marker(
            markerId: MarkerId('marker_${_markers.length}'),
            visible: true,
            position: position,
            infoWindow: const InfoWindow(
              title: 'Order ',
              snippet: 'Order information ',
            ),
          );
          setState(() {
            _markers.add(marker);
            latitude = position.latitude;
            longitude = position.longitude;
          });
         Future.delayed(Duration(milliseconds: 300),() {
           Navigator.pop(context, [latitude, longitude]);
         });
        },
      ),
    );
  }
}
