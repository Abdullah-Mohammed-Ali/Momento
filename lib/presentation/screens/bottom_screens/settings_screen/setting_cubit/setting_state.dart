part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingSuccess extends SettingState {}

class SettingError extends SettingState {}

class EditSuccess extends SettingState {}

class EditLoading extends SettingState {}

class EditError extends SettingState {}

class EditUploadingProfilePictureLoading extends SettingState {}

class EditUploadingProfilePictureLoadingFromStorage extends SettingState {}

class EditUploadingCoverPictureLoadingFromStorage extends SettingState {}

class EditUploadingCoverPictureLoading extends SettingState {}

class EditUploadingProfilePictureSuccess extends SettingState {}

class EditUploadingCoverPictureSuccess extends SettingState {}
