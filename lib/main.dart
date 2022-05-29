import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:segundo_parcia_backend/network/http.dart';
import 'package:segundo_parcia_backend/network/user_repository.dart';
import 'package:segundo_parcia_backend/pages/home.dart';
import 'bloc/restaurant_bloc.dart';
import 'constants.dart';
import 'models/user_model.dart';

User user = User();
UserRepository userRepository = UserRepository();
late GlobalKey<NavigatorState> navKey;

void main() async {
  await dotenv.load(fileName: ".env");

  navKey = GlobalKey<NavigatorState>();
  initDio(navKey: navKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<RestaurantBloc>(
        create: (BuildContext context) => RestaurantBloc(),
    ),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: mesaTheme,
        home: const MyHomePage(title: 'Restaurant'),
      )
    );
  }
}

