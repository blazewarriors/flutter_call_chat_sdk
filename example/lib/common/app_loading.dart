import 'package:example/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          color: ThemeConstants.appColors[ColorConstants.gray300],
        ),
      ),
    );
  }
}
