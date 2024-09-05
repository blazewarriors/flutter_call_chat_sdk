import 'package:example/routes/bloc_provider_config.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splashScreen = '/splashScreen';
  static String permissionLocation = '/permissionLocation';
  static String loginScreen = '/loginScreen';
  static String mainScreen = '/homeScreen';

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => BlocProviderConfig.splashBlocProvider,
    permissionLocation: (context) => BlocProviderConfig.splashBlocProvider,
    // loginScreen: (context) => BlocProviderConfig.loginBlocProvider,
    mainScreen: (context) => BlocProviderConfig.mainBlocProviders,
  };
}
