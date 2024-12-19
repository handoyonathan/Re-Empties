import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class DropPointDetailVM extends BaseNotifier with CustomToastMixin {
  final TextEditingController userController = TextEditingController();
  final TextEditingController stationController = TextEditingController();
  final Admin wasteLocation;
  final String transactionID;
  final String dropID;

  LatLng? position;
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();
  bool showError = false;
  String otp = '';

  DropPointDetailVM(super.ref,
      {required this.wasteLocation,
      required this.transactionID,
      required this.dropID});

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
    // otp = dropID;
    print(position.toString());

    // Tambahkan marker setelah userPosition diatur
    _addWasteLocationMarker();
    notifyListeners();
  }

  void gotoHome(){
    ctx.pushReplacementNamed(paths.home);
    // ctx.replaceNamed(paths.home);
  }

  /// Handle OTP submission
  onFilled(String otpInput) {
    showError = false;

    // Simulate success
    otp = otpInput;
    print("OTP Verified: $otpInput");
    // saveOtpToTransaction(otpInput);
    // showError = false;
    notifyListeners();
  }

  String? getErrorText() {
    if (showError) return ' Kode yang Anda masukkan salah';
    return null;
  }

  void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          onConfirm: () {
            Navigator.of(context).pop(); // Tutup dialog
            deleteTransaction(context);
            print('masuk confirm');
          },
          onCancel: () {
            Navigator.of(context).pop(); // Tutup dialog
            print('masuk cancel');
          },
        );
      },
    );
  }

  void deleteTransaction(BuildContext context) async {
    try {
      // Referensi transaksi pada Firebase
      await FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID)
          .update({'orderStatus': 'Canceled'});

      showCustomToast('Transaction canceled successfully');

      ctx.goNamed(paths.home);
    } catch (e) {
      print('Error deleting transaction: $e');
      showCustomToast('Failed to cancel the transaction. Please try again.',
          isError: true);
    }
  }

  @override
  void dispose() {
    userController.dispose();
    stationController.dispose();
    super.dispose();
  }
}
