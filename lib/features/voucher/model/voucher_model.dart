class Voucher {
  final String voucherID;
  final String category;
  final String title;
  final String description;
  final String points;
  final List<String> termsAndConditions;
  final List<String> howToRedeem;
  final String voucherCode;
  final int stock;
  final List<String>? userUsed;

  Voucher(
      {this.voucherID = "",
      required this.category,
      required this.title,
      required this.description,
      required this.points,
      required this.termsAndConditions,
      required this.howToRedeem,
      required this.voucherCode,
      required this.stock,
      this.userUsed,
      });

  factory Voucher.fromFireStore(Map<String, dynamic> data, String id) {
    return Voucher(
      voucherID: id,
      category: data["category"] ?? "",
      title: data["voucherTitle"] ?? "",
      description: data["voucherDescription"] ?? "",
      points: data["voucherPoint"] ?? "",
      termsAndConditions:
          List<String>.from(data["voucherTermsAndConditions"] ?? []),
      howToRedeem: List<String>.from(data["howToRedeem"] ?? []),
      voucherCode: data["voucherCode"] ?? "",
      stock: data["stock"] ?? 0,
      userUsed: List<String>.from(data["userUsed"] ?? []),
    );
  }
}
