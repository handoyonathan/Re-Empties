import 'package:flutter/material.dart';
import 'package:re_empties/components/custom_text_field.dart';

import 'package:re_empties/constant/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SvgPicture.asset('lib/assets/background/login_background.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              color: CustomColor.green2,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Login with your account.",
                          style: TextStyle(
                              color: CustomColor.green2,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // Email Text Field
                    CustomTextField(
                      hint: "Email",
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: CustomColor.blueText,
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
                    const SizedBox(
                      height: 20.0,
                    ),

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
                    const SizedBox(
                      height: 30.0,
                    ),

                    // Login Dummy Button
                    ElevatedButton(
                      onPressed: () {
                        const Text("Successful login");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 130.0),
                        backgroundColor: CustomColor.green2,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
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
                          child: const Text(
                            "Register Here",
                            style: TextStyle(
                                color: CustomColor.red3,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Text(
                        //   "Register Here",
                        //   style: TextStyle(
                        //       color: CustomColor.red3,
                        //       fontSize: 15.0,
                        //       fontWeight: FontWeight.w700),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
