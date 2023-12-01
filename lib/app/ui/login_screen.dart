import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/data/db_helper.dart';
import 'package:flutter_login_otp/app/ui/otp_screen.dart';
import 'package:flutter_login_otp/app/ui/register_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/user_model.dart';

final _showPasswordProvider = StateProvider<bool>((ref) {
  return true;
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isEmailValid = true;
  final loginFormKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _dbHelper.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                obscureText: ref.watch(_showPasswordProvider),
                enableSuggestions: false,
                autocorrect: false,
                controller: _passwordController,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      ref.watch(_showPasswordProvider) ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref.read(_showPasswordProvider.notifier).state = !ref.watch(_showPasswordProvider);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login button
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      // debugPrint('login berhasil');
                      getLogin(
                        _emailController.text,
                        _passwordController.text,
                      ).then((value) {
                        if (value != null) {
                          context.goNamed(OTPScreen.routeName, extra: value);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email or password is incorrect'),
                            ),
                          );
                        }
                      });
                    }
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

  // get login
  Future<UserModel?> getLogin(String email, String password) async {
    var res = await _dbHelper.getLogin(email, password);
    return res;
  }
}
