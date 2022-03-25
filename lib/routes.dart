import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/presentation/screens/authentecation_screen/login_screen/login.dart';
import 'package:social/presentation/screens/authentecation_screen/register_screen/register.dart';
import 'package:social/presentation/screens/bottom_screens/chats_screen/chats.dart';
import 'package:social/presentation/screens/bottom_screens/settings_screen/setting.dart';
import 'package:social/presentation/screens/bottom_screens/settings_screen/setting_cubit/setting_cubit.dart';
import 'package:social/presentation/screens/bottom_screens/users_screen/users.dart';
import 'package:social/presentation/screens/edit_profile_screen/edit_profile.dart';
import 'package:social/presentation/screens/home_screen/home.dart';
import 'package:social/presentation/screens/splash.dart';

class AppRoutes {
  Route? getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Screens.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case Screens.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case Screens.allExcersing:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UsersScreen());
      case Screens.Today:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChatsScreen());
      case Screens.settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider<SettingCubit>(
                  create: (context) => SettingCubit(),
                  child: SettingScreen(),
                ));
      case Screens.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Screens.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Screens.edit:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
    }
  }
}

class Screens {
  static const splashScreen = '/';
  static const homeScreen = '/home';
  static const Today = '/Today';
  static const allExcersing = '/Excersing';
  static const settings = '/Settings';
  static const login = '/login';
  static const register = '/register';
  static const edit = '/edit';
}
