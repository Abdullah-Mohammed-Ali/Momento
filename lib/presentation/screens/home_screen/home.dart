import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/const/Pallet.dart';
import 'package:social/presentation/components/general.dart';

import 'home_cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            backgroundColor: Pallet.clearColor,
            appBar: MyAppBar(title: cubit.titles[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Pallet.mainColor,
              selectedLabelStyle: TextStyle(color: Pallet.mainColor),
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.bottomNavigation(index);
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOutCubic);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
            body: PageView.builder(
              itemBuilder: (_, index) {
                return cubit.bottomScreens[index];
              },
              onPageChanged: (index) {
                cubit.bottomNavigation(index);
              },
              itemCount: cubit.bottomScreens.length,
              controller: pageController,
            ));
      },
    );
  }
}
