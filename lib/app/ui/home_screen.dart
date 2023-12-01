import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static String routeName = 'home-screen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? username;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, ${username ?? ''}"),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout_sharp,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Welcome!"),
      ),
    );
  }

  // get user login
  getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('userLogin') ?? '';
    setState(() {});
    debugPrint('username: $username');
  }

  // logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userLogin');
    if (context.mounted) {
      context.goNamed(LoginScreen.routeName);
    }
  }
}
