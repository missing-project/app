import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 초기 위치: 서울
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      37.532600,
      127.024612,
    ),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controller = Completer();

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  void _goToUserLocation(LocationData data) async {
    CameraPosition userPosition = CameraPosition(
      target: LatLng(data.latitude!, data.longitude!),
      zoom: 19.151926040649414,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(userPosition));
  }

  void _locateCheck() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData userLocation = await location.getLocation();
    _goToUserLocation(userLocation);
  }

  @override
  void initState() {
    super.initState();
    _locateCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ],
    );
  }
}
