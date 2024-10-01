import 'dart:async';
import 'package:flutter/material.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';

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

  LocationVM(super.ref) {
    userController.addListener(_onUserSearchChanged);
    stationController.addListener(_onStationSearchChanged);
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
    _initializeLocations();
    _initializeWasteStations();
    _resetLocations();
    _resetWasteStations();
  }

  void _initializeLocations() {
    _allLocations = [
      Location(name: "Binus University Kampus Anggrek", address: "Jl. Raya Kb. Jeruk No.27, Jakarta"),
      Location(name: "Plaza Indonesia", address: "Jl. MH Thamrin No.28, Jakarta"),
      Location(name: "Senayan City", address: "Jl. Asia Afrika, Jakarta"),
    ];
  }

  void _initializeWasteStations() {
    _allWasteStations = [
      WasteStation(name: "Station A", address: "Jl. A no.1, Jakarta", openHour: "11.00-12.00", distance: "2km"),
      WasteStation(name: "Station B", address: "Jl. B no.2, Jakarta", openHour: "12.00-13.00", distance: "3km"),
      WasteStation(name: "Station C", address: "Jl. C no.3, Jakarta", openHour: "13.00-14.00", distance: "4km"),
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
      : _allLocations.where((location) =>
          location.name.toLowerCase().contains(query) ||
          location.address.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void _onStationSearchChanged() {
    final query = stationController.text.toLowerCase();
    _wasteStations = query.isEmpty 
      ? List.from(_allWasteStations)
      : _allWasteStations.where((station) =>
          station.name.toLowerCase().contains(query) ||
          station.address.toLowerCase().contains(query)).toList();
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
