class DeliveryOptionModel {
  final String title;
  final String desc;
  final String image;

  DeliveryOptionModel({
    required this.title,
    required this.desc,
    required this.image,
  });

  factory DeliveryOptionModel.fromFirestore(Map<String, dynamic> data) {
    return DeliveryOptionModel(
      title: data['Title'] ?? '',
      desc: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }
}
