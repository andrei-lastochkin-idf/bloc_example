import 'dart:async';
import 'package:domain/model/comment.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http_auth/http_auth.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Comment> comments = [];
  int _page = 0;

  HomeBloc() : super(HomeInitial()) {
    on<InitializeHomeEvent>(
        (event, emit) async => await _getComments(emit, 6));
    on<AddCommentEvent>((event, emit) async => await _getComments(emit, 1));
  }

  Future<void> _getComments(
      Emitter<HomeState> emit, int countOfComments) async {
    for (int _i = 1; _i <= countOfComments; _i++) {
      _page += _i;
      await _fetch(_page);
    }

    emit(HomeLoaded(comments));
  }

  Future _fetch(_page) async {
    final _uri =
        Uri.parse('https://jsonplaceholder.typicode.com/comments/$_page');
    final _client = BasicAuthClient('', '');
    final _response = await _client.get(_uri);
    final _result = commentFromJson(_response.body);

    comments.add(_result);
  }
}
