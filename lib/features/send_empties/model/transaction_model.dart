import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transactionId; // Tambahkan transactionId
  final String userID;
  final String adminID;
  final int? cardboardPcs;
  final double currentLocationLat;
  final double currentLocationLong;
  final DateTime dateTime;
  final String deliveryFee;
  final String? deliveryOption;
  final int earnPoints;
  final int? glassPcs;
  final String orderStatus;
  final String? paymentType;
  final int? plasticPcs;
  final String transactionType;
  final String? dropID;
  final int totalWastePcs;

  TransactionModel({
    this.transactionId = '', // Default kosong jika tidak di-set
    required this.userID,
    required this.adminID,
    this.cardboardPcs,
    required this.currentLocationLat,
    required this.currentLocationLong,
    required this.dateTime,
    required this.deliveryFee,
    this.deliveryOption,
    required this.earnPoints,
    this.glassPcs,
    required this.orderStatus,
    this.paymentType,
    this.plasticPcs,
    required this.transactionType,
    this.dropID,
    required this.totalWastePcs,
  });

  // Menambahkan transactionId dari Firestore doc.id
  factory TransactionModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return TransactionModel(
      transactionId: id, // Set transactionId dari doc.id
      userID: data['userID'] ?? '',
      adminID: data['adminID'] ?? '',
      cardboardPcs: data['cardboardPcs'],
      currentLocationLat: (data['currentLocationLat'] as num?)?.toDouble() ?? 0.0,
      currentLocationLong: (data['currentLocationLong'] as num?)?.toDouble() ?? 0.0,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      deliveryFee: data['deliveryFee'] ?? '0',
      deliveryOption: data['deliveryOption'],
      earnPoints: data['earnPoints'] ?? 0,
      glassPcs: data['glassPcs'],
      orderStatus: data['orderStatus'] ?? '',
      paymentType: data['paymentType'],
      plasticPcs: data['plasticPcs'],
      transactionType: data['transactionType'] ?? '',
      dropID: data['dropID'],
      totalWastePcs: data['totalWastePcs'] ?? 0,
    );
  }

  // Salinan model dengan properti yang diubah
  TransactionModel copyWith({
    String? transactionId,
    String? userID,
    String? adminID,
    int? cardboardPcs,
    double? currentLocationLat,
    double? currentLocationLong,
    DateTime? dateTime,
    String? deliveryFee,
    String? deliveryOption,
    int? earnPoints,
    int? glassPcs,
    String? orderStatus,
    String? paymentType,
    int? plasticPcs,
    String? transactionType,
    String? dropID,
    int? totalWastePcs,
  }) {
    return TransactionModel(
      transactionId: transactionId ?? this.transactionId,
      userID: userID ?? this.userID,
      adminID: adminID ?? this.adminID,
      cardboardPcs: cardboardPcs ?? this.cardboardPcs,
      currentLocationLat: currentLocationLat ?? this.currentLocationLat,
      currentLocationLong: currentLocationLong ?? this.currentLocationLong,
      dateTime: dateTime ?? this.dateTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      earnPoints: earnPoints ?? this.earnPoints,
      glassPcs: glassPcs ?? this.glassPcs,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentType: paymentType ?? this.paymentType,
      plasticPcs: plasticPcs ?? this.plasticPcs,
      transactionType: transactionType ?? this.transactionType,
      dropID: dropID ?? this.dropID,
      totalWastePcs: totalWastePcs ?? this.totalWastePcs,
    );
  }
}
