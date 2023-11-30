import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/ui/register_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static String routeName = 'login-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            // Password field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            // Login button
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
            ),
            const Expanded(child: SizedBox(height: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Don't have account? "),
                InkWell(
                  onTap: () => context.pushNamed(RegisterScreen.routeName),
                  child: const Text(
                    "Register Here.",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
            // Register button
          ],
        ),
      ),
    );
  }
}
