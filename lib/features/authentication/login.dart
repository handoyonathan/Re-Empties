import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/svg_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageAsset(
            imagePath: images.loginBg,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.h),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Login",
                          style: textTheme.headline1,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Login with your account.",
                          style: textTheme.headline2,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Gap(20.h),
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
                      borderRadius: 15.r,
                    ),
                    Gap(20.h),
                    // Password TextField
                    CustomTextField(
                      hint: "Password",
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isPassword: true,
                      isMultiline: false,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      onSubmit: (value) {
                        passwordFocusNode.unfocus(); // Hide keyboard on submit
                        // Call login function
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
                    Gap(25.h),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     const Text("Successful login");
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 15.0, horizontal: 120.0),
                    //     backgroundColor: colors.green2,
                    //   ),
                    //   child: Text(
                    //     'Login',
                    //     style: textTheme.button.copyWith(fontSize: 15),
                    //   ),
                    // ),
                    AppMainButton(
                        state: ButtonState.primary,
                        text: 'Login',
                        onPressed: () {
                          print('hai login');
                        }),
                    Gap(25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: textTheme.subtitle.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Gap(5.w),
                        TapDetector(
                          onTap: () {
                            print('hai');
                          },
                          child: Text(
                            "Register Here",
                            style: textTheme.subtitle.copyWith(
                                color: colors.textButton,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Gap(20.h),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
