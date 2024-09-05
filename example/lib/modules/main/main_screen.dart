import 'package:example/common/app_images.dart';
import 'package:example/constants/constants_color.dart';
import 'package:example/modules/main/bloc/main_bloc.dart';
import 'package:example/modules/main/screen/account/account_screen.dart';
import 'package:example/modules/main/screen/account/bloc/account_bloc.dart';
import 'package:example/modules/main/screen/chats/bloc/chats_bloc.dart';
import 'package:example/modules/main/screen/chats/chats_screen.dart';
import 'package:example/modules/main/screen/friends/bloc/friends_bloc.dart';
import 'package:example/modules/main/screen/friends/friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_chat_sdk/managers/notifications/local_notifications_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Check and request Permission
    requestNotificationPermissions();

    // Initialize the [MainBloc] and fetch the new token.
    final mainBloc = context.read<MainBloc>();
    mainBloc.add(InitializeMain());
    mainBloc.add(FetchNewTokenEvent());
  }

  List<Widget> get _widgetOptions {
    return [
      BlocProvider.value(
        value: BlocProvider.of<ChatsBloc>(context),
        child: const ChatsScreen(),
      ),
      BlocProvider.value(
        value: BlocProvider.of<FriendsBloc>(context),
        child: const FriendsScreen(),
      ),
      BlocProvider.value(
        value: BlocProvider.of<FriendsBloc>(context),
        child: const FriendsScreen(),
      ),
      BlocProvider.value(
        value: BlocProvider.of<AccountBloc>(context),
        child: const AccountScreen(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        _onItemTapped(value);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage(AppImages.user2),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
