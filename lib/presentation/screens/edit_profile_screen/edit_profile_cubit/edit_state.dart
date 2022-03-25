part of 'edit_cubit.dart';

@immutable
abstract class EditState {}

class EditInitial extends EditState {}

class EditSuccess extends EditState {}

class EditLoading extends EditState {}

class EditError extends EditState {}

class EditUploadingPictureLoading extends EditState {}

class EditUploadingPictureSuccess extends EditState {}
