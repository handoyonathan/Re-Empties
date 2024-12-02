class PaymentOptionModel {
  final String title;
  final String desc;
  final String image;

  PaymentOptionModel({
    required this.title,
    required this.desc,
    required this.image,
  });

  factory PaymentOptionModel.fromFirestore(Map<String, dynamic> data) {
    return PaymentOptionModel(
      title: data['Title'] ?? '',
      desc: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }
}
