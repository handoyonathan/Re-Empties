import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';

class _TextTheme {
  final countdown = TextStyle(
    fontSize: 64.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.bgColor,
    fontFamily: 'Inter'
  );
  final headline1 = TextStyle(
    fontSize: 35.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green2,
    fontFamily: 'Inter'
  );
  final dropID = TextStyle(
    fontSize: 24.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  //point value (redeem point)
  final point = TextStyle(
    fontSize: 32.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final badgeLevel = TextStyle(
    fontSize: 30.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final successTitle = TextStyle(
    fontSize: 25.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final voucherCode = TextStyle(
    fontSize: 25.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final articleTitle = TextStyle(
    fontSize: 24.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final headline2 = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w300,
    color: colors.green2,
    fontFamily: 'Inter'
  );
  final button = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.bgColor,
    fontFamily: 'Inter'
  );
  //vouchers title (redeem point)
  final voucher = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final greetingName = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green2,
    fontFamily: 'Inter'
  );
  final featureLabel1 = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.bgColor,
    fontFamily: 'Inter'
  );
  // waste Category Title, Delivery and payment option Title (form send), Your point title, Your level label, Full name (di halaman profile), order history, Home article Label, Recycle Points Title (redeem point), voucher name (redeem point detail)
  final title = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final articleDetail = TextStyle(
    fontSize: 20.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  //auth Label, yourDropID title
  final subtitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.black,
    fontFamily: 'Inter'
  );
  // bisa dipake untuk value trackingID atau Estimated Delivery
  // tinggal ganti warna nya aja ke green1
  final textButton = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.textButton,
    fontFamily: 'Inter'
  );
  //ini bisa dipake untuk subtitle juga di intro, "collect empties" dll
  //bedain weight w700
  final introTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w900,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // bisa dipake untuk waste station title, waste cateogory name
  final appbarTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final locationName = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final trackingStepTitle = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final trackingStepDetail = TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.gray3,
    fontFamily: 'Inter'
  );
  final myPoint = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.red2,
    fontFamily: 'Inter'
  );
  final greetingLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green2,
    fontFamily: 'Inter'
  );
  // bisa buat value dari delivery & payment option (form send), tracking status subtitle (tracking status)
  final formName = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // detail drop point label, edit profile label (halaman profile), voucher code title (redeem point detail)
  final detailDropPointLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  //untuk point di success page, weightnya w700
  final successPointLabel = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final detailDropPoint = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.red4,
    fontFamily: 'Inter'
  );
  // untuk order station Name (transaction history), voucher name (redeem point)
  final orderStationName = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final orderWeightDetail = TextStyle(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  //label untuk dropID desc, textfield Label,
  final textFieldLabel = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final articleDesc = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // label tracking status w400, value tracking id nya w600
  final trackingStatus = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.black,
    fontFamily: 'Inter'
  );
  final errorText = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.normal,
    color: colors.red1,
    fontFamily: 'Inter'
  );
  final orderType = TextStyle(
    fontSize: 13.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // buat angka qty waste, tnc & how to redeem title (redeem point detail)
  final subtitle2 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // badges Text, detail profile (phone num, email)
  final badgesText = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final featureLabel2 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.bgColor,
    fontFamily: 'Inter'
  );
  final redeemPointDetail = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final homeShipLabel1 = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final introLabel = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final locationDescription = TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // buat date and time di order history page
  final orderHistory = TextStyle(
    fontSize: 11.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final homeShipLabel2 = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // "your points" && "+5000 points" (redeem point)
  final pointLabel = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: colors.red2,
    fontFamily: 'Inter'
  );
  //buat location detail, waste category desc, success desc/label, voucher description (redeem point & redeem point detail)
  final label = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  // title w600, desc w400
  final importantNotes = TextStyle(
    fontSize: 10.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final badgesLabel = TextStyle(
    fontSize: 8.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
  );
  final badgesPoint = TextStyle(
    fontSize: 8.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors.green1,
    fontFamily: 'Inter'
  );

  final articleIntro = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: colors.green1,
    fontFamily: 'Inter'
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
