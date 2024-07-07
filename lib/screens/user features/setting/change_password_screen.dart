// change_password_screen.dart

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:graduation_project/screens/user%20features/setting/profile%20services/profile_services.dart';
import '../../../shared/style/custom_button.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../Authentication/widgets/my_custom_text_feild.dart';
import '../forcast/forecast screens/forcasting_screen.dart';
import '../user widgets/menu_icon_list.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmnewpasswordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Passwords must have at least one special character')
  ]);

  ProfileService passwordService = ProfileService();

  @override
  void dispose() {
    newpasswordController.dispose();
    passwordController.dispose();
    confirmnewpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(14, 46, 92, 1),
        actions: const <Widget>[
          MenuIconList(),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, right: 4, left: 16),
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
                padding: EdgeInsets.all(15.0),
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
                              labelText: 'Password',
                              validator: passwordValidator,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                            ),
                            const GradientDivider(),
                            MyCustomTextFormField(
                              obscureText: true,
                              labelText: 'New Password',
                              validator: passwordValidator,
                              controller: newpasswordController,
                              keyboardType: TextInputType.text,
                            ),
                            const GradientDivider(),
                            const SizedBox(height: 14),
                            MyCustomTextFormField(
                              obscureText: true,
                              labelText: 'Confirm New Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm password';
                                }
                                if (value != newpasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null; // Return null if validation passes
                              },
                              controller: confirmnewpasswordController,
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
                                    passwordService.changePassword(
                                      password: passwordController.text,
                                      newPassword: newpasswordController.text,
                                      context: context,
                                    );
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
