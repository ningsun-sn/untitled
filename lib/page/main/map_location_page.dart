import 'dart:math';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/src/types/types.dart';
class MapLocationPage extends StatefulWidget {
  const MapLocationPage({Key? key}) : super(key: key);

  @override
  _MapLocationPageState createState() => _MapLocationPageState();
}

class _MapLocationPageState extends State<MapLocationPage> {
  late AMapController _controller;
  Map<String, Marker> _markers = <String, Marker>{};
  BitmapDescriptor _markerIcon = BitmapDescriptor.fromIconPath('assets/marker_icon.png');
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }
  void _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=====> $status');
  }

  @override
  Widget build(BuildContext context) {

    AMapWidget aMap = AMapWidget(
        privacyStatement: const AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true),
        apiKey: const AMapApiKey(iosKey: "15d31ccab4c5763b600033e4c4d1ca3a", androidKey: "791875f51cb50d8ace85cc2ab0181986"),
        myLocationStyleOptions: MyLocationStyleOptions(
          true,
          // circleFillColor: Colors.lightBlue,
          // circleStrokeColor: Colors.blue,
          // circleStrokeWidth: 1,
        ),
        onMapCreated: (AMapController controller){
          _controller = controller;
        },
        onLocationChanged: _onLocationChanged,
        markers: Set<Marker>.of(_markers.values),
    );
    return Container(
      child: aMap,
    );
  }
  void _onLocationChanged(AMapLocation location) {
    if (null == location) {
      return;
    }
    _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: location.latLng,
        zoom: 14,)));
    _add(location.latLng);
    print('_onLocationChanged ${location.toJson()}');
  }

  void _add(LatLng mapCenter) {
    final int markerCount = _markers.length;
    LatLng markPosition = LatLng(
        mapCenter.latitude + sin(markerCount * pi / 12.0) / 80.0,
        mapCenter.longitude + cos(markerCount * pi / 12.0) / 80.0);
    final Marker marker = Marker(
      position: markPosition,
      icon: _markerIcon,
      infoWindow: InfoWindow(title: '第 $markerCount 个Marker'),
    );
    _markers.clear();
    setState(() {
      _markers[marker.id] = marker;
    });
  }

}
