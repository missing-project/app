import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:missing_application/blocs/case/case_bloc.dart';
import 'package:missing_application/components/card/case_row_card.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/case/widgets/case_bloc_consumer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 초기 위치: 서울
  static double zoomInit = 12;
  List<Marker> _markers = [];
  Case selectedCase = Case.empty;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      37.508095,
      127.027610,
    ),
    zoom: zoomInit,
  );
  final Completer<GoogleMapController> _controller = Completer();

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  void _caselistLoaded(Case _, List<Case> list) {
    final markerlist =
        list.where((el) => el.latitude * el.longitude > 0).map((el) {
      return Marker(
        position: LatLng(el.latitude, el.longitude),
        markerId: MarkerId(el.id),
        onTap: () {
          setState(() {
            selectedCase = el;
          });
        },
      );
    }).toList();

    setState(() {
      _markers = markerlist;
    });
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

    // 권한이 없을 때 리턴값이 오지 않는 에러가 있음
    LocationData userLocation = await location.getLocation();
    final long = userLocation.longitude!;
    final lat = userLocation.latitude!;

    // 대한민국 범위 적용
    if (long > 32 && long < 44 && lat > 123 && lat < 133) {
      _animateCamera(LatLng(long, lat));
    }
  }

  @override
  void initState() {
    super.initState();
    _locateCheck();
    BlocProvider.of<CaseBloc>(context).add(CaseList());
  }

  @override
  Widget build(BuildContext context) {
    return CaseBlocConsumer(
      loaded: _caselistLoaded,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            markers: _markers.toSet(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 0,
            child: CaseSelected(selected: selectedCase),
          ),
        ],
      ),
    );
  }
}

class CaseSelected extends StatefulWidget {
  const CaseSelected({
    super.key,
    required this.selected,
  });

  final Case selected;

  @override
  State<CaseSelected> createState() => _CaseSelectedState();
}

class _CaseSelectedState extends State<CaseSelected> {
  final double _padding = 8.0;
  @override
  Widget build(BuildContext context) {
    if (widget.selected.id.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: CaseRowCard(
          radius: 5,
          detail: widget.selected,
          width: MediaQuery.of(context).size.width - (_padding * 2),
          shadow: BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
