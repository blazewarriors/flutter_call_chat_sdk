import 'package:example/theme/normal/app_colors.dart' as normal_color;
import 'package:example/theme/normal/app_dimension.dart' as normal_dimension;
import 'package:example/theme/dark/app_colors.dart' as dark_color;

enum AppTheme { normal, dark }

class ThemeConstants {
  static Map<String, dynamic> _config = _Config.normalConstants;
  static var currentAppTheme = AppTheme.normal;

  static void setAppTheme(AppTheme theme) {
    currentAppTheme = theme;
    switch (theme) {
      case AppTheme.normal:
        _config = _Config.normalConstants;
        break;
      case AppTheme.dark:
        _config = _Config.darkConstants;
        break;
    }
  }

  static get appColors {
    return _config[_Config.colors];
  }

  static get appDimension {
    return _config[_Config.dimension];
  }
}

class _Config {
  static const colors = "COLORS";
  static const dimension = "DIMENSION";

  static Map<String, dynamic> normalConstants = {
    colors: normal_color.appColors,
    dimension: normal_dimension.appDimension,
  };
  static Map<String, dynamic> darkConstants = {
    colors: dark_color.appColors,
    dimension: normal_dimension.appDimension,
  };
}

class ColorConstants {
  static const primary100 = 'primary100';
  static const primary200 = 'primary200';
  static const primary300 = 'primary300';
  static const primary400 = 'primary400';
  static const primary500 = 'primary500';
  static const primary600 = 'primary600';
  static const gray100 = 'gray100';
  static const gray200 = 'gray200';
  static const gray300 = 'gray300';
  static const gray400 = 'gray400';
  static const info100 = 'info100';
  static const info200 = 'info200';
  static const info300 = 'info300';
  static const success100 = 'success100';
  static const success200 = 'success200';
  static const success300 = 'success300';
  static const warning100 = 'warning100';
  static const warning200 = 'warning200';
  static const warning300 = 'warning300';
  static const danger100 = 'danger100';
  static const danger200 = 'danger200';
  static const danger300 = 'danger300';
  static const white = 'white';
  static const textBody = 'textBody';
}

class DimensionConstants {
  // Font size
  static const title = 'title'; //32sp
  static const heading1 = 'heading1'; //28sp
  static const heading2 = 'heading2'; //24sp
  static const label = 'label'; //18sp
  static const body = 'body'; //16sp
  static const caption = 'caption'; //12sp
}
