import 'package:flutter/material.dart';
import 'package:flutter_login_otp/app/models/user_model.dart';
import 'package:flutter_login_otp/app/data/db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = 'register-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  bool _isEmailValid = true;

  final DatabaseHelper _dbHelper = DatabaseHelper();

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
        title: const Text("Register"),
        actions: const [],
      ),
      body: Form(
        key: registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 4,
              ),
              // Username field
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Username"),
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
              // Confirm  Password field
              TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                validator: (val) {
                  if (val != _passwordController.text) {
                    return "Password must be same as above";
                  } else {
                    _validatePassword(val);
                  }

                  return null;
                },
                decoration: const InputDecoration(labelText: "Confirm Password"),
              ),
              const SizedBox(height: 20),
              // Register button
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (registerFormKey.currentState!.validate()) {
                      debugPrint('register berhasil');
                      await _registerUser();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User registered successfully'),
                          ),
                        );
                      }
                      _clearTextField();
                    }
                  },
                  child: const Text("Register"),
                ),
              ),
              const Expanded(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    UserModel row = UserModel(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    int userId = await _dbHelper.insertUser(row);

    if (userId != -1) {
      // snackbar success

      debugPrint('User registered with ID: $userId');
      // Add navigation logic or other actions here after successful registration
    } else {
      debugPrint('Error registering user');
      // Handle error if registration fails
    }
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
    _isEmailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value ?? '');
    return _isEmailValid ? null : 'Enter a valid email address';
  }

  _clearTextField() {
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}
