import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_otp/app/ui/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});
  static const routeName = 'otp-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  String correctOTP = '111111';
  final _otpFormKey = GlobalKey<FormState>();
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("INPUT OTP"),
        actions: const [],
      ),
      body: Form(
        key: _otpFormKey,
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(),
          height: size.height / 6,
          width: size.width,
          child: Row(
            children: otpControllers
                .asMap()
                .entries
                .map(
                  (e) => Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: otpControllers[e.key],
                            maxLength: 1,
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1 && e.key != 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && e.key > 0) {
                                FocusScope.of(context).previousFocus();
                              }

                              // Verify OTP when the last box is filled
                              if (e.key == 5 && value.isNotEmpty) {
                                verifyOTP();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Visibility(
                          visible: e.key != otpControllers.length - 1,
                          child: const SizedBox(
                            width: 4,
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void verifyOTP() {
    String enteredOTP = otpControllers.map((controller) => controller.text).join();
    if (enteredOTP == correctOTP) {
      // Correct OTP, store username/password locally
      debugPrint("OTP verified successfully!");
      context.goNamed(HomeScreen.routeName);
    } else {
      // Incorrect OTP, you can show an error message to the user
      debugPrint("Incorrect OTP. Please try again.");
    }
  }
}
