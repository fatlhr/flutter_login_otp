import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/models/user_model.dart';
import 'package:flutter_login_otp/app/ui/home_screen.dart';
import 'package:flutter_login_otp/app/ui/login_screen.dart';
import 'package:flutter_login_otp/app/ui/otp_screen.dart';
import 'package:flutter_login_otp/app/ui/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // get user login
    if (prefs.containsKey('userLogin')) {
      // username = prefs.getString('userLogin')!;
      return '/${HomeScreen.routeName}';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: LoginScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: [
        GoRoute(
          path: RegisterScreen.routeName,
          name: RegisterScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterScreen();
          },
        ),
        GoRoute(
          path: OTPScreen.routeName,
          name: OTPScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            UserModel user = state.extra as UserModel;
            return OTPScreen(
              user: user,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/${HomeScreen.routeName}',
      name: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        // String? username = state.extra as String;
        return const HomeScreen();
      },
    ),
  ],
);
