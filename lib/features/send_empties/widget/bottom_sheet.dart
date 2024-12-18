import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/string_extension.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/features/send_empties/model/delivery_model.dart';
import 'package:re_empties/features/send_empties/model/payment_model.dart';

void showOptionsModal<T>({
  required BuildContext context,
  required List<T> options,
  required Function(int) onSelected,
  required int selectedValue,
  String? price, // Add this parameter
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
            children: options.asMap().entries.map((entry) {
              int idx = entry.key;
              var data = entry.value;
              
              final imageUrl = (data is PaymentOptionModel) ? data.image : (data as DeliveryOptionModel).image;
              final optionTitle = (data is PaymentOptionModel) ? data.title : (data as DeliveryOptionModel).title;
              final description = (data is PaymentOptionModel) ? data.desc : (data as DeliveryOptionModel).desc;

              return ListTile(
                leading: ClipOval(
                    child: Image.network(
                  imageUrl,
                  width: 55.w,
                  height: 55.h,
                )),
                title: Text(optionTitle, style: textTheme.trackingStepTitle),
                subtitle: Text(price.isNotNullOrEmpty ? price! : description, style: textTheme.textFieldLabel),
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
