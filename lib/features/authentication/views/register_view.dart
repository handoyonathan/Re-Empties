import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/form_text_field.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/authentication/viewmodel/register_viewmodel.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import '../../../cores/components/hidden_app_bar.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) => BaseView<RegisterVM>(
        provider: registerVM,
        appBar: (_) => const HiddenAppBar(
          backgroundColor: Colors.transparent,
        ),
        builder: _buildScreen,
        extendBodyBehindAppBar: true,
        disableSafeArea: true,
      );

  Widget _buildScreen(BuildContext context, RegisterVM vm) => Scaffold(
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

                  Form(
                      key: vm.formKey,
                      child: Column(
                        children: [
                          FormTextField(
                            inputModel: vm.form.fullName,
                            hint: 'Full Name',
                            prefixWidget: Icon(
                              Icons.people_outline_rounded,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(10.h),
                          FormTextField(
                            hint: 'Email',
                            inputModel: vm.form.email,
                            prefixWidget: Icon(
                              Icons.email_outlined,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(10.h),
                          FormTextField(
                            hint: 'Phone Number',
                            inputModel: vm.form.phoneNumber,
                            prefixWidget: Icon(
                              Icons.phone,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(10.h),
                          FormTextField(
                            hint: "Password",
                            inputModel: vm.form.password,
                            isPassword: true,
                            isMultiline: false,
                            prefixWidget: Icon(
                              Icons.lock_outline_rounded,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(10.h),
                          FormTextField(
                            hint: "Confirm Password",
                            inputModel: vm.form.confirmPassword,
                            isPassword: true,
                            isMultiline: false,
                            prefixWidget: Icon(
                              Icons.lock_outline_rounded,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(10.h),
                        ],
                      )),

                  Gap(20.h),
                  // Register button
                  AppMainButton(
                    state: ButtonState.primary,
                    text: 'Register',
                    onPressed: vm.onRegister,
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
                ],
              ),
            ),
          ),
        ),
      );
}
