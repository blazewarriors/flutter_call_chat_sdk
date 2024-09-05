import 'package:example/modules/main/bloc/main_bloc.dart';
import 'package:example/modules/main/main_screen.dart';
import 'package:example/modules/main/screen/account/bloc/account_bloc.dart';
import 'package:example/modules/main/screen/chats/bloc/chats_bloc.dart';
import 'package:example/modules/main/screen/friends/bloc/friends_bloc.dart';
import 'package:example/modules/main/screen/notification/bloc/notification_bloc.dart';
import 'package:example/modules/splash/bloc/splash_bloc.dart';
import 'package:example/modules/splash/bloc/splash_event.dart';
import 'package:example/modules/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderConfig {
  static BlocProvider<SplashBloc> splashBlocProvider = BlocProvider<SplashBloc>(
    create: (context) => SplashBloc()..add(LoadSplash()),
    child: const SplashScreen(),
  );

  static MultiBlocProvider mainBlocProviders = MultiBlocProvider(
    providers: [
      BlocProvider<MainBloc>(
        create: (context) => MainBloc()..add(FetchNewTokenEvent()),
      ),
      BlocProvider<ChatsBloc>(
        create: (context) => ChatsBloc()..add(OpenConnection()),
      ),
      BlocProvider<FriendsBloc>(
        create: (context) => FriendsBloc()..add(InitializeFriendsEvent()),
      ),
      BlocProvider<NotificationBloc>(
        create: (context) => NotificationBloc()..add(InitializeNotificationEvent()),
      ),
      BlocProvider<AccountBloc>(
        create: (context) => AccountBloc()..add(InitializeAccountEvent()),
      ),
    ],
    child: const MainScreen(),
  );
}
