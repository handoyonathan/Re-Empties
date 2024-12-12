import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String name;
  final String? address;
  final int? rewardsPoint;
  final String? phone;
  final String? email;

  User({
    this.id,
    required this.name,
    this.address,
    this.rewardsPoint,
    this.phone,
    this.email,
  });
}

class Admin {
  final String id;
  final String adminName;
  final String addressStation;
  final String adminPhone;
  final String adminEmail;
  final String stationName;
  final GeoPoint wasteLocation;
  final String openHours;
  double? distance;

  Admin({
    required this.id,
    required this.adminName,
    required this.addressStation,
    required this.adminPhone,
    required this.adminEmail,
    required this.stationName,
    required this.wasteLocation,
    required this.openHours,
    this.distance,
  });

  factory Admin.fromFirestore(Map<String, dynamic> json) {
    return Admin(
      id: '',
      addressStation: json['addressStation'],
      adminPhone: json['adminPhone'],
      stationName: json['stationName'],
      wasteLocation: json['wasteLocation'],
      openHours: json['openHours'],
      adminName: json['adminName'],
      adminEmail: json['adminEmail'],
    );
  }
}


class LocationData {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lon;

  LocationData({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
  });

}