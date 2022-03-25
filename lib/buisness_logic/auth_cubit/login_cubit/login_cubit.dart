import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';
import 'package:social/routes.dart';

import '../../../data/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();

  Users userModel = Users();

  Future login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    userModel = Users(email: email, password: password);
    emit(LoginLoading());
    await FirebaseAuthRepository.login(user: userModel, onError: onError)
        .then((value) {
      emit(LoginSuccess());
      Navigator.pushNamedAndRemoveUntil(
          context, Screens.homeScreen, (_) => false);
    }).catchError((onError) {
      print("Error: " + onError.toString());
      emit(LoginError(error: onError.toString()));
    });
  }
}
