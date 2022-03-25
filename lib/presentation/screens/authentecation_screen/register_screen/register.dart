import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/buisness_logic/auth_cubit/register_cubit/register_cubit.dart';
import 'package:social/const/Pallet.dart';
import 'package:social/presentation/components/buttons.dart';
import 'package:social/presentation/components/general.dart';
import 'package:social/presentation/components/text_field.dart';

import '../../../../const/strings.dart';
import '../../../const.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var usernameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  GlobalKey<FormState> textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SizedBox spacing({double val = 0.03}) => SizedBox(height: height * val);
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            showDialog(context: context, builder: (_) => alertDialog);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return Scaffold(
            backgroundColor: Pallet.clearColor,
            appBar: MyAppBar(
              title: 'Register',
            ),
            body: SingleChildScrollView(
              child: Form(
                key: textKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                              bottom: 45,
                              top: 0,
                              // width: double.maxFinite,
                              left: 0,
                              right: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: cubit.pickedCoverImage != null
                                            ? FileImage(cubit.pickedCoverImage!)
                                                as ImageProvider
                                            : NetworkImage(postPic),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: EditingButton(
                                        onPressed: () async {
                                          await cubit.uploadCoverImage();
                                        },
                                      )),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.passthrough,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Pallet.clearColor,
                                      ),
                                      Positioned(
                                          height: 115,
                                          width: 115,
                                          child: ClipOval(
                                            child: cubit.pickedProfileImage ==
                                                    null
                                                ? Image.network(
                                                    profilePic,
                                                    height: getHeight(context),
                                                    width: getWidth(context),
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.file(
                                                    cubit.pickedProfileImage!),
                                          )),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: EditingButton(
                                            onPressed: () async {
                                              await cubit.uploadProfileImage();
                                            },
                                          ))
                                    ]),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            'Hey! We need few details from you before you start sharing on Momento',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w200),
                          ),
                          spacing(),
                          AppTextField(
                              emailController: nameController,
                              validator: (value) {
                                return validate(
                                    value: value!, hintText: 'Name');
                              },
                              title: 'Name'),
                          spacing(),
                          AppTextField(
                              emailController: usernameController,
                              validator: (value) {
                                return validate(
                                    value: value!, hintText: 'Username');
                              },
                              title: 'Username'),
                          spacing(),
                          AppTextField(
                              emailController: phoneController,
                              validator: (value) {
                                return validate(
                                    value: value!, hintText: 'phone');
                              },
                              title: 'phone'),
                          spacing(),
                          AppTextField(
                              emailController: emailController,
                              validator: (value) {
                                return validate(
                                    value: value!, hintText: 'Email');
                              },
                              title: 'E-mail'),
                          spacing(),
                          AppTextField(
                              obscureText: true,
                              emailController: passController,
                              validator: (value) {
                                return validate(
                                    value: value!, hintText: 'Password');
                              },
                              title: 'Password'),
                          spacing(val: 0.05),
                          AppFlatButton(
                              padding: 0,
                              height: height,
                              onPressed: () async {
                                if (textKey.currentState!.validate()) {
                                  await cubit.register(
                                      email: emailController.text,
                                      password: passController.text,
                                      phone: phoneController.text,
                                      userName: usernameController.text,
                                      name: nameController.text,
                                      context: context);
                                }
                              },
                              title: 'Register'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String? validate({required String value, required String hintText}) {
  if (value.isEmpty) {
    return 'please enter your $hintText';
  }
}
