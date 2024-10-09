import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

void showPaymentOptionsModal({
  required BuildContext context,
  required List<Map<String, String>>
      paymentOptions, // Data untuk gambar, title, desc
  required Function(int) onSelected, // Callback untuk passing nilai pilihan
  required int selectedValue, // Nilai yang dipilih
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: colors.bgColor,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: paymentOptions.asMap().entries.map((entry) {
              int idx = entry.key;
              Map<String, String> data = entry.value;

              return ListTile(
                leading: ClipOval(
                    child: Image.asset(
                  data['image']!,
                  width: 55.w,
                  height: 55.h,
                )),
                title: Text(data['title']!, style: textTheme.trackingStepTitle),
                subtitle: data['desc'] != null
                    ? Text(data['desc']!, style: textTheme.textFieldLabel)
                    : null,
                trailing: Radio<int>(
                  value: idx,
                  groupValue: selectedValue,
                  activeColor: colors.green4,
                  fillColor: WidgetStateProperty.all(colors.green4),
                  onChanged: (int? value) {
                   setState(() {
                        selectedValue = value!;
                      });
                      onSelected(value!);
                  },
                ),
              );
            }).toList(),
          ),
        );
      });
    },
  );
}
