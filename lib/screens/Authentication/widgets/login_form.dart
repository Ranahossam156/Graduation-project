// login_form.dart

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:graduation_project/screens/Authentication/widgets/my_custom_text_feild.dart';
import 'package:graduation_project/shared/style/custom_button.dart';
import 'package:graduation_project/shared/style/gradient_divider.dart';
import '../Auth Services/auth_services.dart';
import '../Authentication screens/forget _password_screen.dart';
import '../Authentication screens/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  final passwordValidator = MultiValidator([
    // RequiredValidator(errorText: 'Please enter password'),
    // MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //  errorText: 'passwords must have at least one special character')
  ]);
  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);

  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
              labelText: 'Email',
              validator: ValidEmail,
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 20.0),
            MyCustomTextFormField(
              obscureText: true,
              labelText: 'Password',
              validator: passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 30,
              width: 140,
              child: CustomButton2(
                onTap: () {
                  if (validateAndSave()) {
                    setState(() {
                      isLoading = true;
                    });
                    authService.login(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    ).whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                },
                text: 'Sign in',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?  ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Sign up',
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
