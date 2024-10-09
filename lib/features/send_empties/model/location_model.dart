import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String name;
  final String? address;
  final int? rewardsPoint;
  final String phone;
  final String email;

  User({
    this.id,
    required this.name,
    this.address,
    this.rewardsPoint,
    required this.phone,
    required this.email,
  });
}

class Admin {
  final String id;
  final String adminName;
  final String address;
  final String stationName;
  final GeoPoint location;

  Admin({
    required this.id,
    required this.adminName,
    required this.address,
    required this.stationName,
    required this.location,
  });
}
