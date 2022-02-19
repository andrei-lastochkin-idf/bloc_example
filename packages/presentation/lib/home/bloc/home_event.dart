part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitializeHomeEvent extends HomeEvent {}

class AddCommentEvent extends HomeEvent {}
