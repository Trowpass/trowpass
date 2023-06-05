// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreenBusiness extends StatelessWidget {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
              Text(
                'Let’s Get Started!',
                style: appStyles(24, null, FontWeight.w600),
              ),
              SizedBox(height: 22),
              Text(
                'Create an account with SanwoPay',
                style: appStyles(
                  16,
                  Colors.black,
                  FontWeight.w400,
                ),
              ),
              SizedBox(height: 32),
              SignupForm(
                businessNameController: businessNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              SizedBox(height: 32),
              Text(
                'Already have an account?',
                style: appStyles(
                  14,
                  grayscale,
                  FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  'Login here',
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

class SignupForm extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignupForm({
    required this.businessNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputForm(
          inputController: businessNameController,
          textLabel: 'Business Name',
          textHint: 'Business Name',
          validatorMessage: 'Please enter a valid business name',
          isPassword: false,
          autoCorrect: false,
          prefixIcon: Icon(
            Icons.business_rounded,
            size: 30,
          ),
        ),
        SizedBox(height: 16),
        TextInputForm(
          inputController: emailController,
          textLabel: 'Company Email',
          textHint: 'Company Email',
          validatorMessage: 'Please enter a valid email',
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
        SizedBox(height: 16),
        TextInputForm(
          inputController: confirmPasswordController,
          textLabel: 'Confirm Password',
          textHint: 'Confirm password',
          validatorMessage: 'Passwords do not match',
          isPassword: true,
          autoCorrect: false,
          prefixIcon: Icon(
            Icons.lock,
            size: 30,
          ),
        ),
        SizedBox(height: 25),
        StandardButton(
          text: 'SIGN UP',
          onPressed: () {
            // Handle individual button press
          },
        ),
      ],
    );
  }
}
