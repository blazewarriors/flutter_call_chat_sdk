import 'package:example/common/app_images.dart';
import 'package:example/common/app_loading.dart';
import 'package:example/modules/splash/bloc/splash_bloc.dart';
import 'package:example/modules/splash/bloc/splash_event.dart';
import 'package:example/modules/splash/bloc/splash_state.dart';
import 'package:example/routes/app_routes.dart';
import 'package:example/routes/common_navigator.dart';
import 'package:example/theme/styles_constants.dart';
import 'package:example/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget _buildStateContent(BuildContext context, SplashState state) {
    if (state is SplashLoading) {
      return const AppLoading();
    }
    if (state is SplashLoaded) {
      return _buildSplashLoaded(state, context);
    }
    // Consider adding an else if for SplashError to handle error states
    return Container(); // For SplashInitial or any other unhandled state
  }

  Widget _buildSplashLoaded(SplashLoaded state, BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _buildLogoAndText(),
        _buildVersionText(context, state.version),
      ],
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      AppImages.bgSplash,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildLogoAndText() {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.logoBrand,
            width: 65.0.sp,
            height: 100.0.sp,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.0.sp),
          SvgPicture.asset(
            AppImages.sophie,
            width: 210.0.w,
            height: 42.0.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildVersionText(BuildContext context, String version) {
    return Positioned(
      bottom: 16.0.h,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          version,
          textAlign: TextAlign.center,
          style: StylesConstants.bodyRegular.copyWith(
            color: ThemeConstants.appColors[ColorConstants.white],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplash()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashInitial) {
            CommonNavigator.navigateTo(context, AppRoutes.mainScreen);
          }
        },
        child: Scaffold(
          body: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) => _buildStateContent(context, state),
          ),
        ),
      ),
    );
  }
}
