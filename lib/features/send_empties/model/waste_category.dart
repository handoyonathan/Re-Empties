class WasteCategoryModel {
  final String title;
  final String desc;
  final String image;
  final int qty;

  WasteCategoryModel ({
    required this.title,
    required this.desc,
    required this.image,
    this.qty = 0,
  });

  factory WasteCategoryModel .fromFirestore(Map<String, dynamic> data) {
    return WasteCategoryModel (
      title: data['Title'] ?? '',
      desc: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }
}
