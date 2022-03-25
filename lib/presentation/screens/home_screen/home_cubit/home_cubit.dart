import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/const/objects.dart';
import 'package:social/presentation/screens/bottom_screens/users_screen/users.dart';

import '../../../../data/models/user.dart';
import '../../../../data/repo/firebase_auth_provider.dart';
import '../../bottom_screens/chats_screen/chats.dart';
import '../../bottom_screens/feeds_screen/feeds_screen.dart';
import '../../bottom_screens/settings_screen/setting.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentIndex = 0;
  List<Widget> bottomScreens = const [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> titles = const ['New Feeds', 'Chats', 'Users', 'Settings'];

  void bottomNavigation(int index) {
    emit(HomeNavigationStart());
    currentIndex = index;
    emit(HomeNavigationEnd());
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  Users? getUser() {
    emit(HomeUserLoading());
    // print('print user : ' + FirebaseAuthRepository.userModel!.image!);

    currentUser = FirebaseAuthRepository.userModel;

    print(currentUser!.image);
    emit(HomeUserSuccess());
  }

  void disposeEdit() {
    emit(HomeUserDispose());
  }
}
