// register_form.dart

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:graduation_project/screens/Authentication/widgets/my_custom_text_feild.dart';
import 'package:graduation_project/shared/style/custom_button.dart';
import 'package:graduation_project/shared/style/gradient_divider.dart';
import '../Auth Services/auth_services.dart';
import '../Authentication screens/login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter confirm password'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter confirm email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);

  AuthService authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCustomTextFormField(
              labelText: 'Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              controller: nameController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 14),
            MyCustomTextFormField(
              labelText: 'Email',
              validator: ValidEmail,
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 14),
            MyCustomTextFormField(
              labelText: 'Password',
              obscureText: true,
              validator: passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 14),
            MyCustomTextFormField(
              obscureText: true,
              labelText: 'Confirm Password',
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
            const SizedBox(height: 14),
            MyCustomTextFormField(
              labelText: 'Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              controller: addressController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 40),
            SizedBox(
              height: 30,
              width: 140,
              child: CustomButton2(
                onTap: () {
                  if (validateAndSave()) {
                    setState(() {
                      isLoading = true;
                    });
                    authService.register(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      address: addressController.text,
                      context: context,
                    ).whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                },
                text: 'Sign up',
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?  ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Color(0xff1FDEF5), fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
