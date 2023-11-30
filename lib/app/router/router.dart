import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/ui/home_screen.dart';
import 'package:flutter_login_otp/app/ui/login_screen.dart';
import 'package:flutter_login_otp/app/ui/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
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
      ],
    ),

    // GoRoute(
    //   path: '/${LoginScreen.routeName}',
    //   name: LoginScreen.routeName,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const LoginScreen();
    //   },
    //   routes: [
    //     GoRoute(
    //       path: OTPScreen.routeName,
    //       name: OTPScreen.routeName,
    //       builder: (BuildContext context, GoRouterState state) {
    //         return const OTPScreen();
    //       },
    //     ),
    //   ],
    // ),
    GoRoute(
      path: '/${HomeScreen.routeName}',
      name: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);
