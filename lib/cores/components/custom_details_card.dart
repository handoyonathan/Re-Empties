import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';

class CustomDetailsCard extends StatelessWidget {
  final String type; // 'transaction' or 'payment'
  final Map<String, dynamic> data; // Data for the card

  const CustomDetailsCard({
    super.key,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isTransaction = type == 'transaction';
    bool isOngoing =
        data['state'] == 'ongoing'; // Check if the state is ongoing
    bool isDone = data['state'] == 'done'; // Check if the state is done

    return Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      color: colors.yellow4, // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section with padding
          Padding(
            padding: EdgeInsets.all(12.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    isTransaction
                        ? "Transaction Waste Details"
                        : "Payment Details",
                    style: textTheme.formName),
                if (isTransaction && isDone)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0.w,
                      vertical: 4.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.red5,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text("+${data['points']} points",
                        style: textTheme.pointLabel
                            .copyWith(color: colors.green1)),
                  ),
              ],
            ),
          ),
    
          // Horizontal Divider spanning full width
          Divider(
            color: colors.yellow6,
            thickness: 1,
            height: 1, // No additional spacing
          ),
    
          // Bottom Section with padding
          Padding(
            padding: EdgeInsets.all(12.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isTransaction
                  ? _buildTransactionRows(data)
                  : _buildPaymentRows(data),
            ),
          ),
        ],
      ),
    );
  }

  // Build rows for Transaction type
  List<Widget> _buildTransactionRows(Map<String, dynamic> data) {
    return [
      _buildRow("Plastic", "${data['plastic']} kg"),
      _buildRow("Glass", "${data['glass']} kg"),
      _buildRow("Cardboard", "${data['cardboard']} kg"),
      Gap(5.h),
      _buildRow("Total", "${data['total']} kg"),
    ];
  }

  // Build rows for Payment type
  List<Widget> _buildPaymentRows(Map<String, dynamic> data) {
    return [
      _buildRow("Handling and Delivery Fee", "${data['fee']}"),
      _buildRow("Subtotal", "${data['subtotal']}"),
      _buildRow("Total", "${data['total']}"),
    ];
  }

  String _formatCurrency(String amount) {
  final double parsedAmount = double.tryParse(amount) ?? 0.0; // Mengonversi string ke double
  final formatter = NumberFormat('#,##0', 'id_ID'); // Format dengan pemisah ribuan untuk Indonesia

  // Menggunakan formatter untuk memformat angka menjadi format yang diinginkan
  return formatter.format(parsedAmount);
}

  // Helper method to build a row with left and right text
  Widget _buildRow(String left, String right) {
    bool isTotal = left == "Total"; // Check if the row is for "Total"

    // Add "Rp" only for payment rows
    String formattedRight = (type == 'payment' &&
            (left == "Handling and Delivery Fee" ||
                left == "Subtotal" ||
                left == "Total"))
        ? "Rp ${_formatCurrency(right)}"
        : right;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left,
              style: isTotal
                  ? textTheme.orderStationName
                  : textTheme.redeemPointDetail),
          Text(formattedRight,
              style:
                  isTotal ? textTheme.orderStationName : textTheme.subtitle2),
        ],
      ),
    );
  }
}
