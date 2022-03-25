part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {}

class RegisterUploadImageLoading extends RegisterState {}

class RegisterUploadImageSuccess extends RegisterState {}

class RegisterUploadImagError extends RegisterState {}
