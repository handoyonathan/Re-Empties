import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/form_text_field.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/authentication/viewmodel/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => BaseView<LoginVM>(
        provider: loginVM,
        appBar: (_) => const HiddenAppBar(
          backgroundColor: Colors.transparent,
        ),
        builder: _buildScreen,
        extendBodyBehindAppBar: true,
        disableSafeArea: true,
      );

  Widget _buildScreen(BuildContext context, LoginVM vm) => Scaffold(
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
                  Form(
                      key: vm.formKey,
                      child: Column(
                        children: [
                          FormTextField(
                            hint: 'Email',
                            inputModel: vm.form.email,
                            prefixWidget: Icon(
                              Icons.email_outlined,
                              color: colors.blueText,
                            ),
                          ),
                          Gap(20.h),
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
                        ],
                      )),
                  Gap(25.h),
                  AppMainButton(
                    state: ButtonState.primary,
                    text: 'Login',
                    onPressed: vm.onLogin,
                  ),
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
                ],
              ),
            ),
          ],
        ),
      );
}
