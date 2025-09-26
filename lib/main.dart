import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/bloc/favourite/favourite_bloc.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => FavoriteBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Spa Booking',
      routerConfig: AppRouter.router,
    );
  }
}
