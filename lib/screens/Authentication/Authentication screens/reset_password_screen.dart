// reset_password_screen.dart

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../../shared/style/custom_button.dart';
import '../../../shared/style/gradient_divider.dart';
import '../Auth Services/auth_services.dart';
import 'package:graduation_project/screens/Authentication/widgets/my_custom_text_feild.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 characters long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Password must have at least one special character'),
  ]);

  final AuthService resetPasswordService = AuthService();

  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    await resetPasswordService.resetPassword(
      email: widget.email,
      password: passwordController.text,
      context: context,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 4, left: 16),
                        child: Image.asset(
                          'assets/images/only_logo.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            'TRAFFIC',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "CodeDemo",
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'DETECTOR',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "CodeDemo",
                              color: Color(0xff3FBEDA),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: globalFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyCustomTextFormField(
                              obscureText: true,
                              labelText: 'New Password',
                              validator: passwordValidator,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                            ),
                            const GradientDivider(),
                            const SizedBox(height: 14),
                            MyCustomTextFormField(
                              obscureText: true,
                              labelText: 'Confirm New Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter confirm password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null; // Return null if validation passes
                              },
                              controller: confirmpasswordController,
                              keyboardType: TextInputType.text,
                            ),
                            const GradientDivider(),
                            const SizedBox(height: 32),
                            SizedBox(
                              height: 30,
                              width: 140,
                              child: CustomButton2(
                                onTap: () {
                                  if (validateAndSave()) {
                                    resetPassword();
                                  }
                                },
                                text: 'Reset',
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
