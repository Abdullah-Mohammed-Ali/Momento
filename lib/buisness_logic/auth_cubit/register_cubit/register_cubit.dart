import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/const/strings.dart';
import 'package:social/data/models/user.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';
import 'package:social/data/use_cases/image_picker.dart';

import '../../../routes.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  File? pickedProfileImage;
  File? pickedCoverImage;

  Future uploadProfileImage() async {
    emit(RegisterUploadImageLoading());
    try {
      pickedProfileImage = await _imagePickerHelper.uploadImage();
      if (pickedProfileImage != null) {
        emit(RegisterUploadImageSuccess());
      }
    } catch (e) {
      emit(RegisterUploadImagError());
    }
  }

  Future uploadCoverImage() async {
    emit(RegisterUploadImageLoading());
    try {
      pickedCoverImage = await _imagePickerHelper.uploadImage();
      if (pickedCoverImage != null) {
        emit(RegisterUploadImageSuccess());
      }
    } catch (e) {
      emit(RegisterUploadImagError());
    }
  }

  Future register(
      {required String name,
      required String userName,
      required String password,
      required String email,
      required String phone,
      required BuildContext context}) async {
    String? profileImage;
    String? coverImage;
    if (pickedProfileImage != null) {
      profileImage =
          await _imagePickerHelper.uploadToStorage(pickedProfileImage!);
    }
    if (pickedCoverImage != null) {
      coverImage = await _imagePickerHelper.uploadToStorage(pickedCoverImage!);
    }
    Users user = Users(
      email: email,
      password: password,
      phone: phone,
      userName: userName,
      image: profileImage ?? profilePic,
      coverImage: coverImage ?? postPic,
    );

    emit(RegisterLoading());
    await FirebaseAuthRepository.register(user: user, then: () {})
        .then((value) {
      emit(RegisterSuccess());
      Navigator.pushReplacementNamed(context, Screens.homeScreen);
    }).catchError((error) => emit(RegisterError()));
  }
}
