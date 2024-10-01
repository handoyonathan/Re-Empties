import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode fullNameFocusedNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusedNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          color: colors.background,
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.h),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageAsset(
                  imagePath: images.logo,
                  height: 107.h,
                  width: 70.w,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      color: colors.green2,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Create a new account.",
                  style: TextStyle(
                      color: colors.green2,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
                Gap(10.h),
      
                // Full name
                CustomTextField(
                  hint: "Full Name",
                  controller: fullNameController,
                  focusNode: fullNameFocusedNode,
                  keyboardType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.people_outline_rounded,
                    color: colors.blueText,
                  ),
                  isMultiline: false,
                  onSubmit: (value) {
                    fullNameFocusedNode.unfocus();
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                  borderRadius: 15.0,
                ),
                Gap(10.h),
      
                // Email
                CustomTextField(
                  hint: "Email",
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: colors.blueText,
                  ),
                  isMultiline: false,
                  onSubmit: (value) {
                    emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  borderRadius: 15.0,
                ),
                Gap(10.h),
      
                // Phone Number
                CustomTextField(
                  hint: "Phone Number",
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusedNode,
                  keyboardType: TextInputType.phone,
                  inputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: colors.blueText,
                  ),
                  isMultiline: false,
                  onSubmit: (value) {
                    phoneNumberFocusedNode.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (!RegExp(r'^08[0-9]{8,11}$').hasMatch(value)) {
                      return "Phone number must start with '08', contain only digits, and be between 10 to 13 digits long.";
                    }
                    return null;
                  },
                  borderRadius: 15.0,
                ),
                Gap(10.h),
      
                // Password
                CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  isPassword: true,
                  isMultiline: false,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  onSubmit: (value) {
                    passwordFocusNode.unfocus(); // Hide keyboard on submit
                    FocusScope.of(context)
                        .requestFocus(confirmPasswordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                Gap(10.h),
      
                // Confirm Password
                CustomTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  isPassword: true,
                  isMultiline: false,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  onSubmit: (value) {
                    confirmPasswordFocusNode.unfocus(); // Hide keyboard on submit
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                Gap(50.h),
      
                // Register button
                AppMainButton(
                  state: ButtonState.primary,
                  text: 'Register',
                  onPressed: () {
                    print('hai regis');
                  },
                ),
                Gap(10.h),
      
                // Login option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Text("berhasil di klik brok");
                      },
                      child: Text(
                        "Login Here",
                        style: TextStyle(
                            color: colors.textButton,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
