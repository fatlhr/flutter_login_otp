import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  static String routeName = 'register-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register"),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height / 4,
            ),
            // Email field
            const TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Username"),
            ),
            // Email field
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            // Password field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(height: 20),
            // Login button
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
              ),
            ),
            const Expanded(child: SizedBox(height: 20)),

            // Register button
          ],
        ),
      ),
    );
  }
}
