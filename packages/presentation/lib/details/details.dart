import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/details_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
        if (state is DetailsInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DetailsLoadedState) {
          return _info(state);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  _info(state) {
    return Column(children: <Widget>[
      Text('Identifier:  ${state.post.id}'),
      Text('Title:  ${state.post.title}'),
      Text('Body:  ${state.post.body}'),
    ]);
  }
}
