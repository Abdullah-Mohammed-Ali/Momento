import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';

import '../../../../data/models/user.dart';
import '../../../../data/provider/network/firestor.dart';
import '../../../../data/use_cases/image_picker.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitial());

  static EditCubit get(context) => BlocProvider.of(context);

  Users? currentUser;

  Users? getUser({
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
  FirestorHelper _firestorHelper = FirestorHelper();

  File? pickedProfilePic;
  File? pickedCoverPic;

  Future uploadProfileImage() async {
    emit(EditUploadingPictureLoading());
    try {
      pickedProfilePic = await _imagePickerHelper.uploadImage();

      await _imagePickerHelper.uploadToStorage(pickedProfilePic!).then((value) {
        currentUser!.image = value;
      });
      print(currentUser!.image);
      emit(EditUploadingPictureSuccess());
    } catch (e) {
      emit(EditError());
    }
  }

  Future uploadCoverImage() async {
    emit(EditUploadingPictureLoading());
    try {
      pickedCoverPic = await _imagePickerHelper.uploadImage();

      await _imagePickerHelper.uploadToStorage(pickedCoverPic!).then((value) {
        currentUser!.coverImage = value;
      });
      print(currentUser!.coverImage);
      emit(EditUploadingPictureSuccess());
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
    if (pickedProfilePic != null) {
      await uploadProfileImage();
    }
    if (pickedCoverPic != null) {
      await uploadCoverImage();
    }
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
      emit(EditSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(EditError());
    });
  }
}
