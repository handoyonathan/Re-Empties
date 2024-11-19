import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';

class LocationVM extends BaseNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController stationController = TextEditingController();

  List<Admin> _wasteStations = [];
  List<Admin> get wasteStations => _wasteStations;

  List<Admin> _queriedWasteStations = [];
  List<Admin> get queriedWasteStations => _queriedWasteStations;

  Admin? _selectedWasteStation;
  Admin? get selectedWasteStation => _selectedWasteStation;

  String? _selectedStationId; // ID station yang dipilih
  String? get selectedStationId => _selectedStationId;

  LatLng? userPosition;
  GoogleMapController? mapController;
  String? stationControllerError;
  late String strAlamat;
  bool isWasteLocationChanged = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LocationVM(super.ref);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> fetchQueriedWasteStations(String query) async {
    try {
      final snapshot = await _firestore.collection('admin').get();
      final stations = snapshot.docs.map((doc) {
        final data = doc.data();
        return Admin(
          id: doc.id,
          addressStation: data['addressStation'],
          adminPhone: data['adminPhone'],
          adminName: data['adminName'],
          adminEmail: data['adminEmail'],
          stationName: data['stationName'],
          wasteLocation: data['wasteLocation'],
        );
      }).toList();

      _queriedWasteStations = stations;
    } catch (e) {
      print('Error fetching queried waste stations: $e');
    } finally {
      isWasteLocationChanged = true;
      notifyListeners();
    }
  }

  Future<void> fetchWasteStations() async {
    try {
      final snapshot = await _firestore.collection('admin').get();
      final stations = snapshot.docs.map((doc) {
        final data = doc.data();
        return Admin(
          id: doc.id,
          addressStation: data['addressStation'],
          adminPhone: data['adminPhone'],
          adminName: data['adminName'],
          adminEmail: data['adminEmail'],
          stationName: data['stationName'],
          wasteLocation: data['wasteLocation'],
        );
      }).toList();

      _wasteStations = stations;
    } catch (e) {
      print('Error fetching waste stations: $e');
    } finally {
      isWasteLocationChanged = false;
      notifyListeners();
    }
  }

  Future<void> _determinePosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      await _getCurrentLocation();
    } catch (e) {
      print('Error determining position: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
      userPosition = LatLng(position.latitude, position.longitude);
      userController.text = await getAddressFromLongLat(position);
      notifyListeners();
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<String> getAddressFromLongLat(Position position) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0];
      strAlamat =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';

      // Mendapatkan User ID dari pengguna yang sedang login
      String? userId = getCurrentUserId();

      // Menulis data ke Firebase Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {'userAddress': strAlamat}, // Menulis atau mengganti field userAddress
        SetOptions(merge: true), // Agar field lain dalam dokumen tetap utuh
      );

      return strAlamat;
    } catch (e) {
      print('Error getting address from coordinates: $e');
      return 'Unknown Address';
    }
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  FutureOr<void> init() {
    _determinePosition();
    fetchWasteStations();
  }

  void onStationSearchChanged(String query) {
    // Mengubah flag agar pencarian tidak berubah saat pertama kali memuat data
    isWasteLocationChanged = true;

    // Filter waste stations berdasarkan query
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua waste stations
      _queriedWasteStations = _wasteStations;
    } else {
      // Filter waste stations berdasarkan kecocokan nama atau alamat
      _queriedWasteStations = _wasteStations.where((station) {
        return station.stationName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            station.addressStation.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    _selectedStationId = null;
    notifyListeners();
  }

  void selectWasteStation(String stationId) {
    // Set ID station yang dipilih
    _selectedStationId = stationId;

    // Cari station berdasarkan ID
    _selectedWasteStation =
        _wasteStations.firstWhere((station) => station.id == stationId);

    // Update stationController.text dengan address station yang dipilih
    stationController.text = _selectedWasteStation!.stationName;

    fetchWasteStations();

    notifyListeners();
  }

  @override
  void dispose() {
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }

  void goToFormPage({required bool? isSend}) {
    if (_selectedWasteStation != null) {
      stationControllerError = null; // Clear previous error
      ctx.pushNamed(paths.sendForm, extra: <String, dynamic> {
        'wasteLocation': _selectedWasteStation,
        'isSend': isSend,
    });
    } else {
      stationControllerError = 'Waste station cannot be empty.';
      print('Station Error: $stationControllerError');
      notifyListeners();
    }
  }
}
