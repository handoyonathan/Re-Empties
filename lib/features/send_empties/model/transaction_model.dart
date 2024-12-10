import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String userID;
  final String adminID;
  final int cardboardWeight;
  final double currentLocationLat;
  final double currentLocationLong;
  final DateTime dateTime;
  final String? deliveryFee;
  final String? deliveryOption;
  final int earnPoints;
  final int glassWeight;
  final String orderStatus;
  final String? paymentType;
  final int plasticWeight;
  final int totalWeight;
  final String transactionType;
  final String? dropID;
  final String? name;
  final String? address;

  TransactionModel({
    required this.userID,
    required this.adminID,
    required this.cardboardWeight,
    required this.currentLocationLat,
    required this.currentLocationLong,
    required this.dateTime,
    this.deliveryFee,
    this.deliveryOption,
    required this.earnPoints,
    required this.glassWeight,
    required this.orderStatus,
    this.paymentType,
    required this.plasticWeight,
    required this.totalWeight,
    required this.transactionType,
    this.dropID,
    this.name,
    this.address,
  });

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    return TransactionModel(
      userID: data['userID'] ?? '',
      adminID: data['adminID'] ?? '',
      cardboardWeight: data['cardboardWeight'] ?? '',
      currentLocationLat: (data['currentLocationLat'] as num?)?.toDouble() ?? 0.0,
      currentLocationLong: (data['currentLocationLong'] as num?)?.toDouble() ?? 0.0,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      deliveryFee: data['deliveryFee'],
      deliveryOption: data['deliveryOption'],
      earnPoints: data['earnPoints'] ?? 0,
      glassWeight: data['glassWeight'] ?? 0,
      orderStatus: data['orderStatus'],
      paymentType: data['paymentType'],
      plasticWeight: data['plasticWeight'] ?? 0,
      totalWeight: data['totalWeight'] ?? 0,
      transactionType: data['transactionType'] ?? '',
      dropID: data['dropID'],
    );
  }
}
