import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';

import '../../../../../const/objects.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/use_cases/image_picker.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of(context);

  void getUser() {
    emit(SettingLoading());

    if (FirebaseAuthRepository.userModel != null) {
      currentUser = FirebaseAuthRepository.userModel;
    } else {
      emit(SettingError());
    }
  }

  Users? getUserEdit({
    required TextEditingController bio,
    required TextEditingController name,
    required TextEditingController phone,
  }) {
    emit(EditLoading());
    if (FirebaseAuthRepository.userModel != null) {
      bio.text = FirebaseAuthRepository.userModel!.bio!;
      name.text = FirebaseAuthRepository.userModel!.userName!;
      phone.text = FirebaseAuthRepository.userModel!.phone!;

      currentUser = FirebaseAuthRepository.userModel;

      emit(EditSuccess());
      return currentUser;
    } else {}
  }

  ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  File? pickedProfilePic;
  File? pickedCoverPic;

  Future uploadProfileImage() async {
    try {
      pickedProfilePic = await _imagePickerHelper.uploadImage();
      emit(EditUploadingProfilePictureLoadingFromStorage());

      print(currentUser!.image);
    } catch (e) {
      emit(EditError());
    }
  }

  Future uploadProfileImageButton() async {
    emit(EditUploadingProfilePictureLoading());
    await _imagePickerHelper.uploadToStorage(pickedProfilePic!).then((value) {
      currentUser!.image = value;
      emit(EditUploadingProfilePictureSuccess());
    });
  }

  Future uploadCoverImageButton() async {
    emit(EditUploadingCoverPictureLoading());
    await _imagePickerHelper.uploadToStorage(pickedCoverPic!).then((value) {
      currentUser!.coverImage = value;
      emit(EditUploadingCoverPictureSuccess());
    });
  }

  Future uploadCoverImage() async {
    try {
      pickedCoverPic = await _imagePickerHelper.uploadImage();
      emit(EditUploadingCoverPictureLoadingFromStorage());

      print(currentUser!.coverImage);
    } catch (e) {
      emit(EditError());
    }
  }

  Future updateUser({
    required TextEditingController bio,
    required TextEditingController name,
    required TextEditingController phone,
    required BuildContext context,
  }) async {
    emit(EditLoading());

    Users user = Users(
      email: currentUser!.email,
      password: currentUser!.password,
      phone: phone.text,
      uId: currentUser!.uId,
      userName: name.text,
      image: currentUser!.image,
      coverImage: currentUser!.coverImage,
    );

    print('current user : ' + user.toString());
    await FirebaseAuthRepository.updateUser(
      user: user,
    ).then((value) {
      getUser();
      emit(EditSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(EditError());
    });
  }
}
