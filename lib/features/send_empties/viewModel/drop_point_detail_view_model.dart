import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';

class DropPointDetailVM extends BaseNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController stationController = TextEditingController();
  final Admin wasteLocation;
  final String transactionId;

  LatLng? position;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  final formKey = GlobalKey<FormState>();
  bool showError = false;
  String otp = ''; // The generated OTP code

  DropPointDetailVM(super.ref, {required this.wasteLocation, required this.transactionId});

  /// Called when the GoogleMap is created
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Tambahkan marker untuk lokasi wasteLocation
    _addWasteLocationMarker();
  }

  /// Function to add marker for wasteLocation
  void _addWasteLocationMarker() {
  final LatLng location = LatLng(
    wasteLocation.wasteLocation.latitude,
    wasteLocation.wasteLocation.longitude,
  );

  markers.add(
    Marker(
      markerId: MarkerId(wasteLocation.stationName),
      position: location,
      infoWindow: InfoWindow(
        title: wasteLocation.stationName,
        snippet: wasteLocation.addressStation,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  );

  notifyListeners();
}


  @override
  FutureOr<void> init() {
    // Set userPosition ke lokasi waste station
    position = LatLng(
      wasteLocation.wasteLocation.latitude,
      wasteLocation.wasteLocation.longitude,
    );
    otp = _generateRandomPin();
    print(position.toString());

    // Tambahkan marker setelah userPosition diatur
    _addWasteLocationMarker();
    notifyListeners();
  }

  String _generateRandomPin() {
    final random = Random();
    final numbers = List.generate(4, (_) => random.nextInt(10)).join();
    return 'DO$numbers';
  }

  void saveOtpToTransaction(String otp) async {
  try {
    // Ambil reference dari koleksi "transaction"
    final transactionRef = FirebaseFirestore.instance
          .collection('admin')
          .doc(wasteLocation.id)
          .collection('transactions').doc(transactionId);

    final transactionData = {
      'dropID': otp,
    };

    // Menyimpan data ke koleksi "transaction"
    await transactionRef.update(transactionData);

    print('OTP saved to transaction with dropID: $otp');
  } catch (e) {
    print('Error saving OTP to transaction: $e');
  }
}


  /// Handle OTP submission
  onFilled(String otpInput) {
    showError = false;

    // Simulate success
    otp = otpInput;
    print("OTP Verified: $otpInput");
    saveOtpToTransaction(otpInput);
    showError = false;
    notifyListeners();
  }

  String? getErrorText() {
    if (showError) return ' Kode yang Anda masukkan salah';
    return null;
  }


  @override
  void dispose() {
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }
}
