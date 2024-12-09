import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String userID;
  final String adminID;
  final String cardboardWeight;
  final double currenLocationLat;
  final double currenLocationLong;
  final DateTime dateTime;
  final String deliveryFee;
  final String deliveryOption;
  final int earnPoints;
  final int glassWeight;
  final String orderStatus;
  final String paymentType;
  final int plasticWeight;
  final int totalWeight;
  final String transactionType;
  final String dropID;

  TransactionModel({
    required this.userID,
    required this.adminID,
    required this.cardboardWeight,
    required this.currenLocationLat,
    required this.currenLocationLong,
    required this.dateTime,
    required this.deliveryFee,
    required this.deliveryOption,
    required this.earnPoints,
    required this.glassWeight,
    required this.orderStatus,
    required this.paymentType,
    required this.plasticWeight,
    required this.totalWeight,
    required this.transactionType,
    required this.dropID,
  });

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    return TransactionModel(
      userID: data['userID'] ?? '',
      adminID: data['adminID'] ?? '',
      cardboardWeight: data['cardboardWeight'] ?? '',
      currenLocationLat: (data['currenLocationLat'] as num?)?.toDouble() ?? 0.0,
      currenLocationLong: (data['currenLocationLong'] as num?)?.toDouble() ?? 0.0,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      deliveryFee: data['deliveryFee'] ?? '',
      deliveryOption: data['deliveryOption'] ?? '',
      earnPoints: data['earnPoints'] ?? 0,
      glassWeight: data['glassWeight'] ?? 0,
      orderStatus: data['orderStatus'] ?? '',
      paymentType: data['paymentType'] ?? '',
      plasticWeight: data['plasticWeight'] ?? 0,
      totalWeight: data['totalWeight'] ?? 0,
      transactionType: data['transactionType'] ?? '',
      dropID: data['dropID'],
    );
  }
}
