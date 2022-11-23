import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:missing_application/blocs/case/case_bloc.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/case/widgets/case_bloc_consumer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 초기 위치: 서울
  static double zoomInit = 13;
  List<Marker> _markers = [];
  String _selected = '';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      37.498095,
      127.027610,
    ),
    zoom: zoomInit,
  );
  final Completer<GoogleMapController> _controller = Completer();

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  void _addMarker(LatLng cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      _markers.add(
        Marker(
            position: cordinate,
            markerId: MarkerId(id.toString()),
            onTap: () {
              setState(() {
                _selected = id.toString();
              });
            }),
      );
    });
  }

  void _caselistLoaded(Case _, List<Case> list) {
    final markerlist = list
        .map((el) => Marker(
              position: LatLng(el.latitude, el.longitude),
              markerId: MarkerId(el.id),
            ))
        .toList();
    setState(() {
      _markers = markerlist;
    });

    print(markerlist);
  }

  void _getCaseList() {
    BlocProvider.of<CaseBloc>(context).add(CaseList());
  }

  void _animateCamera(LatLng cordinate) async {
    CameraPosition userPosition = CameraPosition(
      target: LatLng(cordinate.latitude, cordinate.longitude),
      zoom: zoomInit,
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
    // _animateCamera(LatLng(userLocation.longitude!, userLocation.latitude!));
    _getCaseList();
  }

  @override
  void initState() {
    super.initState();
    _locateCheck();
  }

  @override
  Widget build(BuildContext context) {
    return CaseBlocConsumer(
      loaded: _caselistLoaded,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: _markers.toSet(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // onTap: (cordinate) {
            // print(cordinate);
            // _animateCamera(cordinate);
            // _addMarker(cordinate);
            // },
          ),
          Positioned(
            bottom: 0,
            child: CaseSelected(id: _selected),
          ),
        ],
      ),
    );
  }
}

class CaseSelected extends StatefulWidget {
  const CaseSelected({super.key, required this.id});

  final String id;

  @override
  State<CaseSelected> createState() => _CaseSelectedState();
}

class _CaseSelectedState extends State<CaseSelected> {
  final double _padding = 8.0;
  @override
  Widget build(BuildContext context) {
    if (widget.id.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width - (_padding * 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(widget.id),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
