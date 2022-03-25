import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social/data/models/user.dart';
import 'package:social/data/provider/local/cashe_helper.dart';
import 'package:social/data/provider/network/firestor.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';
import 'package:social/presentation/components/buttons.dart';
import 'package:social/routes.dart';

import '../../const/strings.dart';
import '../const.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isClicked = false;
  double scale = 10 * pi;
  double startScale = 0;
  bool showSlogan = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isClicked = !isClicked;
      });

      // FirebaseAuth.instance.authStateChanges();
      Future.delayed(const Duration(milliseconds: 1800), () async {
        if (CasheHelper.getData(key: uidKey) != null) {
          print('uid : ' + CasheHelper.getData(key: uidKey));
          await FirestorHelper()
              .getDocFromCollection(
                  collectionPath: usersCollection,
                  docPath: CasheHelper.getData(key: uidKey))
              .then((value) {
            Map<String, dynamic> data = value.data() as Map<String, dynamic>;
            FirebaseAuthRepository.userModel = Users.FromJSON(json: data);
          });
          // print("Auth" + CasheHelper.getData(key: uidKey));
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacementNamed(context, Screens.homeScreen);
          });
        } else {
          setState(() {
            showSlogan = !showSlogan;
          });
        }
      });
    });
    // Future.delayed(const Duration(seconds: 4), () {
    //   Navigator.pushReplacementNamed(context, Screens.login);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Positioned(
          top: height * 0.13,
          left: 0,
          right: 0,
          child: TweenAnimationBuilder(
            builder: (BuildContext context, double value, Widget? child) {
              return Transform.rotate(
                angle: value,
                child: AnimatedOpacity(
                  curve: Curves.easeInOutCubic,
                  duration: const Duration(milliseconds: 1500),
                  opacity: isClicked ? 1 : 0,
                  child: GestureDetector(
                    onTap: () async {
                      print(startScale);

                      setState(() {
                        print(isClicked);
                      });
                    },
                    child: Container(
                      height: height * 0.32,
                      child: Image.asset(
                        'assets/images/splash.png',
                      ),
                    ),
                  ),
                ),
              );
            },
            duration: Duration(milliseconds: 1200),
            tween: Tween<double>(begin: startScale, end: scale),
          ),
        ),
        Positioned(
          top: height * 0.45,
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedOpacity(
            opacity: showSlogan ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      INTRO,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.115,
                ),
                AppFlatButton(
                  height: height,
                  onPressed: () {
                    Navigator.pushNamed(context, Screens.login);
                  },
                  title: 'Login',
                ),
                SizedBox(
                  height: height * 0.065,
                ),
                Center(
                  child: AppTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Screens.register);
                    },
                    title: 'Create New Account',
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
