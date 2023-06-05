// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:app/screens/auth/account_type_screen.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailPhoneNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(login_img),
              Align(
                 alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Welcome back!',
                      style: appStyles(24, null, FontWeight.w600),
                    ),
                    SizedBox(height: 22),
                    Text(
                      'Log in to your account.',
                      style: appStyles(
                        16,
                        Colors.black,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              LoginForm(
                emailPhoneNumberController: emailPhoneNumberController,
                passwordController: passwordController,
              ),
              SizedBox(height: 32),
              Text(
                'Don’t have an account?',
                style: appStyles(
                  14,
                  grayscale,
                  FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => AccountTypeScreen());
                },
                child: Text(
                  'Signup',
                  style: appStyles(
                    14,
                    secondaryColor,
                    FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController emailPhoneNumberController;
  final TextEditingController passwordController;

  LoginForm({
    required this.emailPhoneNumberController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputForm(
          inputController: emailPhoneNumberController,
          textLabel: 'Email or phone number',
          textHint: 'Email or phone number',
          validatorMessage: 'Please enter a valid email or phone number',
          isPassword: false,
          autoCorrect: false,
          prefixIcon: Icon(
            Icons.email_outlined,
            size: 30,
          ),
        ),
        SizedBox(height: 16),
        TextInputForm(
          inputController: passwordController,
          textLabel: 'Password',
          textHint: 'Password',
          validatorMessage: 'Please enter a valid password',
          isPassword: true,
          autoCorrect: false,
          prefixIcon: Icon(
            Icons.lock,
            size: 30,
          ),
        ),
        SizedBox(height: 25),
        StandardButton(
          text: 'LOG IN',
          onPressed: () {
            // Handle individual button press
          },
        ),
      ],
    );
  }
}
