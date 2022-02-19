import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/bloc/home_bloc.dart';
import 'details/bloc/details_bloc.dart';
import 'package:presentation/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(InitializeHomeEvent()),
        ),
        BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc()..add(InitializeDetailsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'BloC example',
        initialRoute: '/',
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
                settings: routeSettings,
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
                settings: routeSettings,
              );
          }
        },
      ),
    );
  }
}
