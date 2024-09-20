import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:re_empties/cores/constant/colors.dart';

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
      body: Container(
        color: colors.background,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
          child: Form(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Image(
                        image: AssetImage('assets/image/logo/logo.png')),
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
                    const SizedBox(height: 10.0),
                  ],
                ),

                // Form Register
                // full name
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
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  borderRadius: 15.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),

                //email
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
                const SizedBox(
                  height: 10.0,
                ),

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
                const SizedBox(
                  height: 10.0,
                ),

                // password
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
                const SizedBox(
                  height: 10.0,
                ),

                // confirm password
                CustomTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  isPassword: true,
                  isMultiline: false,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  onSubmit: (value) {
                    confirmPasswordFocusNode
                        .unfocus(); // Hide keyboard on submit
                    // Call login function
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
                const SizedBox(
                  height: 10.0,
                ),

                // Register Dummy Button
                ElevatedButton(
                  onPressed: () {
                    const Text("Successful login");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 130.0),
                    backgroundColor: colors.green2,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10.0),

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
