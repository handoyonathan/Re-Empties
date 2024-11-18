import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/form_text_field.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/profile/view%20model/edit_profile_view_model.dart';

class EditProfileView extends ConsumerStatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  EditProfileView(
      {super.key,
      required this.fullName,
      required this.email,
      required this.phoneNumber})
      : _viewmodel = ChangeNotifierProvider.autoDispose<EditProfileVM>(
            EditProfileVM.new);
  final AutoDisposeChangeNotifierProvider<EditProfileVM> _viewmodel;

  @override
  ConsumerState<EditProfileView> createState() => EditProfileViewState();
}

class EditProfileViewState extends ConsumerState<EditProfileView> {
  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(widget._viewmodel);
    viewModel.initializeForm(
      fullName: widget.fullName,
      email: widget.email,
      phoneNumber: widget.phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewmodel,
      appBar: (_) => CustomAppBar(
        title: Text(
          'Edit Profile',
          style: textTheme.title,
        ),
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, EditProfileVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 35.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormTextField(
                  hint: 'Full Name',
                  inputModel: vm.form.fullName,
                  prefixWidget: Icon(
                    Icons.person_2_outlined,
                    color: colors.blueText,
                  ),
                ),
                Gap(20.h),
                FormTextField(
                  hint: "Email",
                  inputModel: vm.form.email,
                  isPassword: false,
                  isMultiline: false,
                  prefixWidget: Icon(
                    Icons.email_outlined,
                    color: colors.blueText,
                  ),
                ),
                Gap(20.h),
                FormTextField(
                  hint: 'Phone Number',
                  inputModel: vm.form.phoneNumber,
                  prefixWidget: Icon(
                    Icons.phone,
                    color: colors.blueText,
                  ),
                ),
                Gap(50.h),
                AppMainButton(
                    state: ButtonState.primary,
                    text: 'Save Profile',
                    onPressed: () async {
                      await vm.saveProfileData();
                      context.go('/profile');
                    })
              ],
            ),
          ),
        ),
      );
}
