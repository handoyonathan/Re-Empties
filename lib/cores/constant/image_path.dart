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
  final String errorIllustration = '$_imagePath/error_illustration.png';
  final String articlePreview = '$_imagePath/articlePreview.png';
  final String level1 = '$_imagePath/level1.png';
  final String level2 = '$_imagePath/level2.png';
  final String level3 = '$_imagePath/level3.png';
  final String level4 = '$_imagePath/level4.png';
  final String level5 = '$_imagePath/level5.png';

  // patterns ///////////////////////////////////////
  final String headerMenuUtama = '$_patternPath/Header_MenuUtama.png';

  // bottom nav bar /////////////////////////////////
  final Map<bool, String> homeTab = {
    false: '$_iconPath/Menu_Home_Inactive.svg',
    true: '$_iconPath/Menu_Home_Active.svg',
  };
  final Map<bool, String> polisTab = {
    false: '$_iconPath/Menu_Polis_Inactive.svg',
    true: '$_iconPath/Menu_Polis_Active.svg',
  };
  final Map<bool, String> klaimTab = {
    false: '$_iconPath/Menu_Klaim_Inactive.svg',
    true: '$_iconPath/Menu_Klaim_Active.svg',
  };
  final Map<bool, String> poinTab = {
    false: '$_iconPath/Menu_Point_Inactive.svg',
    true: '$_iconPath/Menu_Point_Active.svg',
  };
  final Map<bool, String> akunTab = {
    false: '$_iconPath/Menu_Akun_Inactive.svg',
    true: '$_iconPath/Menu_Akun_Active.svg',
  };
}

final images = _ImagePath();
