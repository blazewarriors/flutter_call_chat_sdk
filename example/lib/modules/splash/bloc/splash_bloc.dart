import 'package:example/modules/splash/bloc/splash_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadSplash>(_onFetchAppVersion);
  }

  Future<void> _onFetchAppVersion(LoadSplash event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    final version = await _getVersion();
    emit(SplashLoaded(version));
    await Future.delayed(Duration(seconds: 3));
    emit(SplashInitial());
  }

  Future<String> _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
