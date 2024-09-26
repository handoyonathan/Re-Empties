import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';

class _TextTheme {
  final headline1 = TextStyle(
    fontSize: 35.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green2,
  );
  //point value (redeem point)
  final point = TextStyle(
    fontSize: 32.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
  final badgeLevel = TextStyle(
    fontSize: 30.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
  );
  final successTitle = TextStyle(
    fontSize: 25.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
  );
  final voucherCode = TextStyle(
    fontSize: 25.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
  );
  final articleTitle = TextStyle(
    fontSize: 24.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
  );
  final headline2 = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w300,
    color: colors.green2,
  );
  final button = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.bgColor,
  );
  //vouchers title (redeem point)
  final voucher = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
  final greetingName = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green2,
  );
  final featureLabel1 = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.bgColor,
  );
  // waste Category Title, Delivery and payment option Title (form send), Your point title, Your level label, Full name (di halaman profile), order history, Home article Label, Recycle Points Title (redeem point), voucher name (redeem point detail)
  final title = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
  );
  final articleDetail = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  //auth Label, yourDropID title
  final subtitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.black,
  );
  // bisa dipake untuk value trackingID atau Estimated Delivery
  // tinggal ganti warna nya aja ke green1 
  final textButton = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.textButton,
  );
  //ini bisa dipake untuk subtitle juga di intro, "collect empties" dll
  //bedain weight w700
  final introTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
  );
  // bisa dipake untuk waste station title, waste cateogory name
  final appbarTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
  );
  final locationName = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  final trackingStepTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  final trackingStepDetail = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.gray3,
  );
  final myPoint = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.red2,
  );
  final greetingLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green2,
  );
  // bisa buat value dari delivery & payment option (form send), tracking status subtitle (tracking status)
  final formName = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
  // detail drop point label, edit profile label (halaman profile), voucher code title (redeem point detail)
  final detailDropPointLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  //untuk point di success page, weightnya w700
  final successPointLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final detailDropPoint = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.red4,
  );
  // untuk order station Name (transaction history), voucher name (redeem point)
  final orderStationName = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
  );
  final orderWeightDetail = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  //label untuk dropID desc, textfield Label, 
  final textFieldLabel = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final articleDesc = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  // label tracking status w400, value tracking id nya w600
  final trackingStatus = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.black,
  );
  final errorText = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.normal,
    color: colors.red1,
  );
  // buat angka qty waste, tnc & how to redeem title (redeem point detail)
  final subtitle2 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
  // badges Text, detail profile (phone num, email)
  final badgesText = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final featureLabel2 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.bgColor,
  );
  final redeemPointDetail = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final homeShipLabel1 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  final introLabel = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final locationDescription = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  // buat date and time di order history page
  final orderHistory = TextStyle(
    fontSize: 11.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
  );
  final homeShipLabel2 = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  // "your points" && "+5000 points" (redeem point)
  final pointLabel = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.red2,
  );
  //buat location detail, waste category desc, success desc/label, voucher description (redeem point & redeem point detail)
  final label = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  // title w600, desc w400
  final importantNotes = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
  final badgesLabel = TextStyle(
    fontSize: 8.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
  );
  final badgesPoint = TextStyle(
    fontSize: 8.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
  );
}

final textTheme = _TextTheme();

// weight Template
// 100	Thin (Hairline)	-
// 200	Extra Light	-
// 300	Light	-
// 400	Regular	Normal
// 500	Medium	-
// 600	Semi Bold	-
// 700	Bold	Bold
// 800	Extra Bold	-
// 900	Heavy Bold	-
// 950	Ultra Bold	-
