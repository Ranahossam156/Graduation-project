// edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/user%20features/setting/profile%20services/profile_services.dart';
import '../../../models/UserModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../user widgets/menu_icon_list.dart';
import '../user widgets/text_feild.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routName = "setting";
  final Result user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carLicenseController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter confirm email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
  ]);

  ProfileService profileService = ProfileService();

  @override
  initState()  {
    super.initState();
    // Print the token to check its value
    // Result? user = await ApiManager().fetchUserByToken(token!);
    nameController = TextEditingController(text: widget.user?.name);

    emailController =TextEditingController(text:widget.user?.email);
    addressController = TextEditingController(text:widget.user?.address);
    carLicenseController = TextEditingController(text:widget.user?.carLicense);
    //passwordController = TextEditingController(text:user.;

  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    carLicenseController.dispose();
    passwordController.dispose();
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
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100, // Adjust width to make the button larger
                        height: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/profile.png"), // <-- BACKGROUND IMAGE
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
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
                      const SizedBox(height: 10),
                      MyTextField(
                        labelText: 'Email',
                        validator: ValidEmail,
                        controller: emailController,
                        keyboardType: TextInputType.text,
                      ),
                      const GradientDivider(),
                      const SizedBox(height: 10),
                      MyTextField(
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
                      const SizedBox(height: 10),
                      MyTextField(
                        labelText: 'Car License',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your car license';
                          }
                          return null;
                        },
                        controller: carLicenseController,
                        keyboardType: TextInputType.text,
                      ),
                      const GradientDivider(),
                      MyTextField(
                        obscureText: true,
                        labelText: 'Password',
                        validator: passwordValidator,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                      ),
                      const GradientDivider(),
                      const SizedBox(height: 10), // Use the GradientDivider here
                      const SizedBox(height: 90),
                      ElevatedButton(
                        onPressed: () {
                          profileService.updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            carLicense: carLicenseController.text,
                            password: passwordController.text,
                            context: context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0E2F5C),
                          textStyle: const TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
