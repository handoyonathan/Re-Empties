import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: colors.green6,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.green1, width: 2),
        ),
        child: ListTile(
          title: Row(
            children: [
              Text(
                'Nama - ',
                style: textTheme.title,
              ),
              Text(
                'Tipe Orderan',
                style: textTheme.title,
              ),
            ],
          ),
          subtitle: Text(
            'Jl. Raya Kb. Jeruk No.27, RT.1/RW.9, Kemanggisan, Kec. Palmerah, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: colors.green1),
        ),
      ),
    );
  }
}