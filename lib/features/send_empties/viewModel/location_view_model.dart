import 'dart:async';
import 'package:flutter/material.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationVM extends BaseNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController stationController = TextEditingController();

  List<Location> _allLocations = [];
  List<Location> _locations = [];
  List<Location> get locations => _locations;

  List<WasteStation> _allWasteStations = [];
  List<WasteStation> _wasteStations = [];
  List<WasteStation> get wasteStations => _wasteStations;

  String? _selectedLocation;
  String? get selectedLocation => _selectedLocation;

  String? _selectedWasteStation;
  String? get selectedWasteStation => _selectedWasteStation;

  bool _showLocations = true; // Track which list to show
  bool get showLocations => _showLocations;

  LatLng? userPosition;
  GoogleMapController? mapController;

  LocationVM(super.ref) {
    userController.addListener(_onUserSearchChanged);
    stationController.addListener(_onStationSearchChanged);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await _getCurrentLocation();
}

  Future<void> _getCurrentLocation() async {
    try {
      
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
      userPosition = LatLng(position.latitude, position.longitude);
      print(userPosition);
      notifyListeners();
    } catch (e) {
      print('rusak');
      print('Error mendapatkan lokasi: $e');
    }
  }

  void toggleShowLocations() {
    _showLocations = true;
    _resetLocations();
  }

  void toggleShowWasteStations() {
    _showLocations = false;
    _resetWasteStations();
  }

  void _resetLocations() {
    _locations = List.from(_allLocations);
    notifyListeners();
  }

  void _resetWasteStations() {
    _wasteStations = List.from(_allWasteStations);
    notifyListeners();
  }

  @override
  FutureOr<void> init() {
    _determinePosition();
    _initializeLocations();
    _initializeWasteStations();
    _resetLocations();
    _resetWasteStations();
  }

  void _initializeLocations() {
    _allLocations = [
      Location(
          name: "Binus University Kampus Anggrek",
          address: "Jl. Raya Kb. Jeruk No.27, Jakarta"),
      Location(
          name: "Plaza Indonesia", address: "Jl. MH Thamrin No.28, Jakarta"),
      Location(name: "Senayan City", address: "Jl. Asia Afrika, Jakarta"),
    ];
  }

  void _initializeWasteStations() {
    _allWasteStations = [
      WasteStation(
          name: "Station A",
          address: "Jl. A no.1, Jakarta",
          openHour: "11.00-12.00",
          distance: "2km"),
      WasteStation(
          name: "Station B",
          address: "Jl. B no.2, Jakarta",
          openHour: "12.00-13.00",
          distance: "3km"),
      WasteStation(
          name: "Station C",
          address: "Jl. C no.3, Jakarta",
          openHour: "13.00-14.00",
          distance: "4km"),
    ];
  }

  void selectLocation(String locationName) {
    _selectedLocation = locationName;
    userController.text = locationName;
    _resetLocations();
    notifyListeners();
  }

  void selectWasteStation(String stationName) {
    _selectedWasteStation = stationName;
    stationController.text = stationName;
    _resetWasteStations();
    notifyListeners();
  }

  void _onUserSearchChanged() {
    final query = userController.text.toLowerCase();
    _locations = query.isEmpty
        ? List.from(_allLocations)
        : _allLocations
            .where((location) =>
                location.name.toLowerCase().contains(query) ||
                location.address.toLowerCase().contains(query))
            .toList();
    notifyListeners();
  }

  void _onStationSearchChanged() {
    final query = stationController.text.toLowerCase();
    _wasteStations = query.isEmpty
        ? List.from(_allWasteStations)
        : _allWasteStations
            .where((station) =>
                station.name.toLowerCase().contains(query) ||
                station.address.toLowerCase().contains(query))
            .toList();
    notifyListeners();
  }

  @override
  void dispose() {
    userController.removeListener(_onUserSearchChanged);
    stationController.removeListener(_onStationSearchChanged);
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }
}
