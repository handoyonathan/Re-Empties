import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transactionId; // Tambahkan transactionId
  final String userID;
  final String adminID;
  final int? cardboardWeight;
  final double currentLocationLat;
  final double currentLocationLong;
  final DateTime dateTime;
  final int deliveryFee;
  final String? deliveryOption;
  final int earnPoints;
  final int? glassWeight;
  final String orderStatus;
  final String? paymentType;
  final int? plasticWeight;
  final int? totalWeight;
  final String transactionType;
  final String? dropID;
  final String? name;
  final String? address;
  final String? date;
  final String? time;
  final int totalWastePcs;

  TransactionModel({
    this.transactionId = '', // Default kosong jika tidak di-set
    required this.userID,
    required this.adminID,
    this.cardboardWeight,
    required this.currentLocationLat,
    required this.currentLocationLong,
    required this.dateTime,
    required this.deliveryFee,
    this.deliveryOption,
    required this.earnPoints,
    this.glassWeight,
    required this.orderStatus,
    this.paymentType,
    this.plasticWeight,
    this.totalWeight,
    required this.transactionType,
    this.dropID,
    this.name,
    this.address,
    this.date,
    this.time,
    required this.totalWastePcs,
  });

  // Menambahkan transactionId dari Firestore doc.id
  factory TransactionModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return TransactionModel(
      transactionId: id, // Set transactionId dari doc.id
      userID: data['userID'] ?? '',
      adminID: data['adminID'] ?? '',
      cardboardWeight: data['cardboardWeight'],
      currentLocationLat: (data['currentLocationLat'] as num?)?.toDouble() ?? 0.0,
      currentLocationLong: (data['currentLocationLong'] as num?)?.toDouble() ?? 0.0,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      deliveryFee: data['deliveryFee'] ?? 0,
      deliveryOption: data['deliveryOption'],
      earnPoints: data['earnPoints'] ?? 0,
      glassWeight: data['glassWeight'],
      orderStatus: data['orderStatus'] ?? '',
      paymentType: data['paymentType'],
      plasticWeight: data['plasticWeight'],
      totalWeight: data['totalWeight'] ?? 0,
      transactionType: data['transactionType'] ?? '',
      dropID: data['dropID'],
      // name: data['name'],
      // address: data['address'],
      totalWastePcs: data['totalWastePcs'] ?? 0,
    );
  }

  // Salinan model dengan properti yang diubah
  TransactionModel copyWith({
    String? transactionId,
    String? userID,
    String? adminID,
    int? cardboardWeight,
    double? currentLocationLat,
    double? currentLocationLong,
    DateTime? dateTime,
    int? deliveryFee,
    String? deliveryOption,
    int? earnPoints,
    int? glassWeight,
    String? orderStatus,
    String? paymentType,
    int? plasticWeight,
    int? totalWeight,
    String? transactionType,
    String? dropID,
    String? name,
    String? address,
    String? date,
    String? time,
    int? totalWastePcs,
  }) {
    return TransactionModel(
      transactionId: transactionId ?? this.transactionId,
      userID: userID ?? this.userID,
      adminID: adminID ?? this.adminID,
      cardboardWeight: cardboardWeight ?? this.cardboardWeight,
      currentLocationLat: currentLocationLat ?? this.currentLocationLat,
      currentLocationLong: currentLocationLong ?? this.currentLocationLong,
      dateTime: dateTime ?? this.dateTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      earnPoints: earnPoints ?? this.earnPoints,
      glassWeight: glassWeight ?? this.glassWeight,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentType: paymentType ?? this.paymentType,
      plasticWeight: plasticWeight ?? this.plasticWeight,
      totalWeight: totalWeight ?? this.totalWeight,
      transactionType: transactionType ?? this.transactionType,
      dropID: dropID ?? this.dropID,
      name: name ?? this.name,
      address: address ?? this.address,
      date: date ?? this.date,
      time: time ?? this.time,
      totalWastePcs: totalWastePcs ?? this.totalWastePcs,
    );
  }
}
