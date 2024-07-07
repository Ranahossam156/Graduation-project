import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../shared/style/custom_button.dart';
import '../Auth Services/auth_services.dart';

class OTPScreen extends StatelessWidget {
  final String email;
   OTPScreen({super.key, required this.email});

  AuthService otpService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 16, right: 4, left: 7),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.17,
                        ),
                        child: const Text(
                          'Confirmation code',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: const Color(0xff076092),
                        cursorColor: const Color(0xff076092),
                        focusedBorderColor: const Color(0xff076092),
                        margin: const EdgeInsets.only(right: 10.0),
                        textStyle: const TextStyle(
                            color: Color(0xff076092), fontSize: 18),
                        fillColor: Colors.white,
                        showFieldAsBox: true,
                        filled: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (code) {
                          otpService.verifyCode(
                            code: code,
                            email: email,
                            context: context,
                          );
                          print("OTP is => $code");
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        height: 30,
                        width: 140,
                        child: CustomButton2(
                          onTap: () {},
                          text: 'Confirm',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
