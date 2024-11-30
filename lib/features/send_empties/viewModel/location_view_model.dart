import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';

class LocationVM extends BaseNotifier with CustomToastMixin {
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
  // String? stationControllerError;
  late String strAlamat;
  bool isWasteLocationChanged = false;
  late String openHour;
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
        final openHours = stationAvailability(data['openHours']);

        return Admin(
          id: doc.id,
          addressStation: data['addressStation'],
          adminPhone: data['adminPhone'],
          adminName: data['adminName'],
          adminEmail: data['adminEmail'],
          stationName: data['stationName'],
          wasteLocation: data['wasteLocation'],
          openHours: openHours,
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
        final openHours = stationAvailability(data['openHours']);

        return Admin(
          id: doc.id,
          addressStation: data['addressStation'],
          adminPhone: data['adminPhone'],
          adminName: data['adminName'],
          adminEmail: data['adminEmail'],
          stationName: data['stationName'],
          wasteLocation: data['wasteLocation'],
          openHours: openHours,
        );
      }).toList();

      _wasteStations = stations;
      await calculateDistancesForAllWasteStations();
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

  String stationAvailability(String openHours) {
    try {
      List<String> parts = openHours.split(' - ');
      String startTime = parts[0];
      String endTime = parts[1];

      final now = DateTime.now().toUtc().add(const Duration(hours: 7));
      final nowFormatted = DateFormat('HH:mm').format(now);

      final start = DateFormat('HH:mm').parse(startTime);
      final end = DateFormat('HH:mm').parse(endTime);
      final current = DateFormat('HH:mm').parse(nowFormatted);

      if (current.isAfter(start) && current.isBefore(end)) {
        return 'Open | $openHours';
      } else {
        return 'Closed | $openHours';
      }
    } catch (e) {
      print('Error parsing open hours: $e');
      return 'Unknown';
    }
  }

  Future<void> calculateDistancesForAllWasteStations() async {
  // Check if user position is available
  if (userPosition == null) {
    print('User position is null.');
    return;
  }

  // Iterate through all waste stations and calculate the distance for each
  for (var station in _wasteStations) {
    final wasteLocation = station.wasteLocation;
    double lat1 = userPosition!.latitude;
    double lon1 = userPosition!.longitude;
    double lat2 = wasteLocation.latitude;
    double lon2 = wasteLocation.longitude;

    // Calculate the distance
    double distanceInMeters = await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double distanceInKm = distanceInMeters / 1000; // Convert meters to kilometers

    // Format the distance to two decimal places
    String formattedDistance = distanceInKm.toStringAsFixed(2);

    // Save the formatted distance to the waste station
    station.distance = double.tryParse(formattedDistance); // Store as double or as string if you prefer
  }

  // Notify listeners to update the UI
  notifyListeners();
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
    _selectedWasteStation =
        _wasteStations.firstWhere((station) => station.id == stationId);

    // Validasi apakah station masih open
    if (_selectedWasteStation != null) {
      if (_selectedWasteStation!.openHours.contains('Closed')) {
        print('Cannot select this station because it is currently closed.');
        showCustomToast('Cannot select a closed station.', isError: true);
        notifyListeners();
        return;
      }

      // Set ID station yang dipilih jika valid
      _selectedStationId = stationId;

      // Update stationController.text dengan nama station yang dipilih
      stationController.text = _selectedWasteStation!.stationName;
    } else {
      print('Station not found.');
    }

    notifyListeners();
  }

  void calculateDistance() async {
    double lat1 = -6.1751; // Latitude Jakarta
    double lon1 = 106.8650; // Longitude Jakarta
    double lat2 = -7.2504; // Latitude Bandung
    double lon2 = 112.7688; // Longitude Bandung

    // Menghitung jarak antara dua titik
    double distanceInMeters =
        await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double distanceInKm =
        distanceInMeters / 1000; // Mengonversi meter ke kilometer

    print(
        'Jarak antara Jakarta dan Bandung adalah: ${distanceInKm.toStringAsFixed(2)} km');
  }

  @override
  void dispose() {
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }

  void goToFormPage({required bool? isSend}) {
    if (_selectedWasteStation != null) {
      ctx.pushNamed(paths.sendForm, extra: <String, dynamic>{
        'wasteLocation': _selectedWasteStation,
        'isSend': isSend,
      });
    } else {
      showCustomToast('Waste station cannot be empty.', isError: true);
      print('Station Error: Waste station cannot be empty.');
      notifyListeners();
    }
  }
}
