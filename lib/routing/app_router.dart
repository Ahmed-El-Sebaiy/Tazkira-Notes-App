import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tazkira/logic/auth/auth_cubit.dart';
import 'package:tazkira/logic/note/note_cubit.dart';
import 'package:tazkira/routing/routes.dart';
import 'package:tazkira/screens/home_screen.dart';
import 'package:tazkira/screens/signin_screen.dart';
import 'package:tazkira/screens/signup_screen.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => AuthCubit(),
                child: SignInScreen(),
              ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => NoteCubit(),
                child: HomeScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text(
                    'No route here',
                  ),
                ),
              ),
        );
    }
  }
}