import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'bloc/home_bloc.dart';
import '../details/bloc/details_bloc.dart';
import '../details/details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeLoaded) {
            return _scrollView(context, state);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _scrollView(context, state) {
    final HomeBloc _bloc = BlocProvider.of<HomeBloc>(context);
    return LazyLoadScrollView(
      onEndOfPage: () {
        _bloc.add(AddCommentEvent());
      },
      child: ListView.builder(
        itemCount: state.comments.length,
        itemBuilder: (context, i) {
          return _itemsElement(context, state.comments[i]);
        },
      ),
    );
  }

  _itemsElement(context, element) {
    final DetailsBloc _bloc = BlocProvider.of<DetailsBloc>(context);

    return GestureDetector(
      onTap: () {
        _bloc.add(LoadDetailsEvent(element.id));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
      },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: ListTile(
          title: Text(element.name.toString()),
          subtitle: Text(element.body.toString()),
          leading: CircleAvatar(child: Text(element.id.toString())),
        ),
      ),
    );
  }
}
