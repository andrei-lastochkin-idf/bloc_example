part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class InitializeDetailsEvent extends DetailsEvent {}

class LoadDetailsEvent extends DetailsEvent {
  final int id;

  LoadDetailsEvent(this.id);
}
