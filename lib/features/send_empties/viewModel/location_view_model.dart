import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/string_extension.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationVM extends BaseNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController stationController = TextEditingController();

  List<User> _locations = [];
  List<User> get locations => _locations;

  List<Admin> _wasteStations = [];
  List<Admin> get wasteStations => _wasteStations;

  User? _selectedUserLocation;
  User? get selectedUserLocation => _selectedUserLocation;

  Admin? _selectedWasteStation;
  Admin? get selectedWasteStation => _selectedWasteStation;

  LatLng? userPosition;
  GoogleMapController? mapController;

  bool _showLocations = true;
  bool get showLocations => _showLocations;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LocationVM(super.ref) {
    userController.addListener(onUserSearchChanged);
    stationController.addListener(onStationSearchChanged);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> fetchLocations({String? query}) async {
    try {
      QuerySnapshot snapshot;
      if (query.isNotNullOrEmpty) {
        snapshot = await _firestore.collection('users').get();

        _locations = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return User(
            name: data['userName'],
            email: data['userEmail'],
            id: data['userID'],
            rewardsPoint: data['rewardsPoint'],
            phone: data['userPhoneNumber'],
            address: data['userAddress'],
          );
        }).where((user) {
          return user.name.toLowerCase().contains(query!.toLowerCase()) ||
              user.address!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        snapshot = await _firestore.collection('users').get();
        _locations = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return User(
            name: data['userName'],
            email: data['userEmail'],
            id: data['userID'],
            rewardsPoint: data['rewardsPoint'],
            phone: data['userPhoneNumber'],
            address: data['userAddress'],
          );
        }).toList();
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> fetchWasteStations({String? query}) async {
    try {
      QuerySnapshot snapshot;
      if (query != null && query.isNotEmpty) {
        snapshot = await _firestore.collection('admin').get();
        _wasteStations = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Admin(
            id: data['adminID'],
            address: data['addressName'],
            adminName: data['adminName'],
            stationName: data['stationName'],
            location: data['wasteLocation'],
          );
        }).where((admin) {
          return admin.stationName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              admin.address.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        snapshot = await _firestore.collection('admin').get();
        _wasteStations = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Admin(
            id: data['adminID'],
            address: data['addressName'],
            adminName: data['adminName'],
            stationName: data['stationName'],
            location: data['wasteLocation'],
          );
        }).toList();
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching waste stations: $e');
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));
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
    fetchLocations();
    notifyListeners();
  }

  void _resetWasteStations() {
    fetchWasteStations();
    notifyListeners();
  }

  @override
  FutureOr<void> init() {
    _determinePosition();
    fetchLocations();
    fetchWasteStations();
    _resetLocations();
    _resetWasteStations();
  }

  void onUserSearchChanged() {
    final query = userController.text.toLowerCase();
    if (query.isNotNullOrEmpty) {
      fetchLocations(query: query);
    } else {
      fetchLocations();
    }
    _showLocations = true;
    notifyListeners();
  }

  void onStationSearchChanged() {
    final query = stationController.text.toLowerCase();
    if (query.isNotNullOrEmpty) {
      fetchWasteStations(query: query);
    } else {
      fetchWasteStations();
    }
    _showLocations = false;
    notifyListeners();
  }

  void selectLocation(String query) {
    final selected = _locations.firstWhere(
        (location) => location.name == query || location.address == query);
    _selectedUserLocation = selected;
    userController.text = query;
    notifyListeners();
  }

  void selectWasteStation(String query) {
    final selected = _wasteStations.firstWhere(
        (station) => station.stationName == query || station.address == query);
    _selectedWasteStation = selected;
    stationController.text = query;
    notifyListeners();
  }

  @override
  void dispose() {
    userController.removeListener(onUserSearchChanged);
    stationController.removeListener(onStationSearchChanged);
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }
}
