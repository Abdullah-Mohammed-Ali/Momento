import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/buisness_logic/auth_cubit/login_cubit/login_cubit.dart';
import 'package:social/const/Pallet.dart';
import 'package:social/presentation/components/buttons.dart';
import 'package:social/routes.dart';

import '../../../components/general.dart';
import '../../../components/text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Pallet.clearColor,
        appBar: MyAppBar(title: 'Sign In'),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              setState(() {
                showDialog(context: context, builder: (_) => alertDialog);
              });
            } else if (state is LoginError) {
              if (state.error.contains('There is no user record')) {
                Navigator.pop(context);
                AlertDialog alertDialog = AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Center(child: Text('Error')),
                  content: Container(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            'The user is not found \n you need to sign up first'),
                        SizedBox(
                          height: 35,
                        ),
                        AppFlatButton(
                            padding: 0,
                            height: MediaQuery.of(context).size.height,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);

                              Navigator.pushNamed(context, Screens.register);
                            },
                            title: 'Sign UP')
                      ],
                    ),
                  ),
                );
                showDialog(context: context, builder: (_) => alertDialog);
              }
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: textKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * 0.32,
                        child: Image.asset(
                          'assets/images/splash.png',
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      const Text(
                        'Type in your Email ID and Password you chose for'
                        '\n Momento and click Go to Feed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Pallet.Shado,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      AppTextField(
                        emailController: emailController,
                        validator: (value) {
                          if (value!.isEmpty) return 'enter your email';
                        },
                        title: 'Email',
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      AppTextField(
                        emailController: passController,
                        validator: (String? value) {
                          if (value!.isEmpty) return 'enter your password';
                        },
                        title: 'Password',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      AppFlatButton(
                        padding: 0,
                        height: height,
                        title: 'Sign in',
                        onPressed: () async {
                          if (textKey.currentState!.validate()) {
                            await cubit.login(
                                email: emailController.text,
                                password: passController.text,
                                context: context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
