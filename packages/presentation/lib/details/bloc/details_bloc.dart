import 'dart:async';
import 'package:http_auth/http_auth.dart';

import 'package:domain/model/post.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitialState()) {
    on<InitializeDetailsEvent>((event, emit) {});
    on<LoadDetailsEvent>((event, emit) async {
      emit(DetailsInitialState());

      final _post = await _getPostById(event.id);

      emit(DetailsLoadedState(_post));
    });
  }

  Future<Post> _getPostById(_id) async {
    final _uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/$_id');
    final _client = BasicAuthClient('', '');
    final _response = await _client.get(_uri);

    return (postFromJson(_response.body));
  }
}
