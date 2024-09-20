const String _iconPath = 'assets/icons';
const String _imagePath = 'assets/images';
const String _patternPath = 'assets/patterns';

class _ImagePath {
  // icons //////////////////////////////////////////////
  // final String arrowBack = '$_iconPath/Arrow_Back.svg';


  // images ////////////////////////////////////////////////////
  final String registerLogo = '$_imagePath/register_logos.png';
  final String loginBg = '$_imagePath/login_bg.png';

  // patterns ///////////////////////////////////////
  // final String headerMenuUtama = '$_patternPath/Header_MenuUtama.png';
  
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
