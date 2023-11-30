import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/ui/otp_screen.dart';
import 'package:flutter_login_otp/app/ui/register_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isEmailValid = true;
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: const [],
      ),
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 4,
              ),
              // Email field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: _validateEmail,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 12),
              // Password field
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: _validatePassword,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),
              // Login button
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      debugPrint('login berhasil');
                      context.pushNamed(OTPScreen.routeName);
                    }

                    // if (emailError == null && passwordError == null) {
                    //   // Both email and password are valid, perform login logic here
                    //   print("Login button pressed");
                    // } else {
                    //   // Show error messages for invalid input
                    //   print("Invalid input. Email: $emailError, Password: $passwordError");
                    // }
                  },
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
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value != null) {
      if (value.length < 8) {
        return 'Password must contain at least 8 characters';
      } else if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain at least a lowercase letter';
      } else if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least an uppercase letter';
      } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Password must contain at least a symbol';
      }
    }
    return null; // Return null if the password is valid
  }

  String? _validateEmail(String? value) {
    isEmailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value ?? '');
    return isEmailValid ? null : 'Enter a valid email address';
  }
}
