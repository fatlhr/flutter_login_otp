import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static String routeName = 'home-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hi, ..."),
        actions: [
          IconButton(
            onPressed: () {},
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
}
