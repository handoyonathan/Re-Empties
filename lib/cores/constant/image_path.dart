const String _iconPath = 'assets/icons';
const String _imagePath = 'assets/images';
const String _patternPath = 'assets/patterns';
const String _logoPath = 'assets/images/logo';

class _ImagePath {
  // icons //////////////////////////////////////////////
  // final String arrowBack = '$_iconPath/Arrow_Back.svg';

  // images ////////////////////////////////////////////////////
  final String registerLogo = '$_imagePath/register_logos.png';
  final String loginBg = '$_imagePath/login_bg.png';
  final String logoSignUp = '$_logoPath/logo.png';
  final String pointImg = '$_imagePath/point.png';
  final String sendWaste = '$_imagePath/sendWaste.png';
  final String dropWaste = '$_imagePath/dropWaste.png';
  final String logo = '$_logoPath/logo.png';
  final String location = '$_imagePath/location.png';
  final String gosend = '$_imagePath/gosend.jpg';
  final String grabExpress = '$_imagePath/grabexpress.png';
  final String paxel = '$_imagePath/paxel.png';
  final String gopay = '$_imagePath/gopay.png';
  final String shopeePay = '$_imagePath/shopeepay.jpg';
  final String errorIllustration = '$_imagePath/error_illustration.png';
  final String articlePreview = '$_imagePath/articlePreview.png';
  final String level1 = '$_imagePath/level1.png';
  final String level2 = '$_imagePath/level2.png';
  final String level3 = '$_imagePath/level3.png';
  final String level4 = '$_imagePath/level4.png';
  final String level5 = '$_imagePath/level5.png';
  final String reedemBg = '$_imagePath/reedemBg.png';
  final String categoryFoodBev = '$_imagePath/categoryFoodBev.png';
  final String categoryShopping = '$_imagePath/categoryShopping.png';
  final String categoryGames = '$_imagePath/categoryGames.png';
  final String categoryDefault = '$_imagePath/categoryDefault.png';
  final String address = '$_imagePath/address.png';
  final String adminProfile = '$_imagePath/admin_profile.png';
  final String successCircle = '$_imagePath/success_circle.png';
  final String successStar = '$_imagePath/success_star.png';
  final String successBg = '$_imagePath/success_bg.png';
  final String profileUser = '$_imagePath/user_profile_picture.png';
  final String pointsProfile = '$_imagePath/background_level_profile.png';
  final String voucherCoffee = '$_imagePath/voucherCoffee.png';

  // patterns ///////////////////////////////////////
  final String headerMenuUtama = '$_patternPath/Header_MenuUtama.png';

  // bottom nav bar /////////////////////////////////
  final Map<bool, String> homeTab = {
    false: '$_imagePath/home_inactive.png',
    true: '$_imagePath/home_active.png',
  };
  final Map<bool, String> transactionTab = {
    false: '$_imagePath/transaction_inactive.png',
    true: '$_imagePath/transaction_active.png',
  };
  final Map<bool, String> profileTab = {
    false: '$_imagePath/profile_inactive.png',
    true: '$_imagePath/profile_active.png',
  };
}

final images = _ImagePath();
