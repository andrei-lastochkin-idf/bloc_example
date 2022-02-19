part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitialState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  final Post post;

  DetailsLoadedState(this.post);
}
