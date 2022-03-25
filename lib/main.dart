import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/data/provider/local/cashe_helper.dart';
import 'package:social/presentation/screens/home_screen/home_cubit/home_cubit.dart';
import 'package:social/routes.dart';

import 'buisness_logic/bloc_observer.dart';
import 'const/Pallet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await CasheHelper.init();
  BlocOverrides.runZoned(() => runApp(MyApp()), blocObserver: MyBlocObserver());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppRoutes appRoutes = AppRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Pallet.regText,
                unselectedItemColor: Pallet.ShadoIcon),
            appBarTheme: const AppBarTheme(
                backgroundColor: Pallet.clearColor,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Pallet.regText,
                ))),
        onGenerateRoute: appRoutes.getRoutes,
        initialRoute: Screens.splashScreen,
      ),
    );
  }
}
