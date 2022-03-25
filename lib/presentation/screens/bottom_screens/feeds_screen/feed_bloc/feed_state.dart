part of 'feed_cubit.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedSuccess extends FeedState {}

class FeedError extends FeedState {}
