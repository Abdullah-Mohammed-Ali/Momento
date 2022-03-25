part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeNavigationStart extends HomeState {}

class HomeNavigationEnd extends HomeState {}

class HomeUserLoading extends HomeState {}

class HomeUserSuccess extends HomeState {}

class HomeUserError extends HomeState {}

class HomeUserDispose extends HomeState {}
