import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/viewModel/location_view_model.dart';
import 'package:re_empties/features/send_empties/viewModel/send_form_view_model.dart';
import 'package:re_empties/features/send_empties/widget/bottom_sheet.dart';

class SendFormView extends StatefulWidget {
  SendFormView({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<SendFormVM>(SendFormVM.new);

  final AutoDisposeChangeNotifierProvider<SendFormVM> _viewModel;

  @override
  SendFormState createState() => SendFormState();
}

class SendFormState extends State<SendFormView> {
  int _selectedPaymentMethod = 0; // Track selected payment method

  @override
  Widget build(BuildContext context) => BaseView(
        provider: widget._viewModel,
        appBar: (_) => CustomAppBar(
          title: Text('Send Form', style: textTheme.appbarTitle),
        ),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, SendFormVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add form elements here
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: colors.bgColor,
          alignment: Alignment.center,
          height: 70.h,
          child: AppMainButton(
            state: ButtonState.primary,
            text: 'Confirm',
            onPressed: () {
              _showPaymentOptions();
            },
          ),
        ),
      );

  void _showPaymentOptions() {
    List<Map<String, String>> paymentOptions = [
      {
        'image': images.gopay,
        'title': 'Gopay',
        'desc': 'Pay with Gopay'
      },
      {
        'image': images.shopeePay,
        'title': 'ShopeePay',
        'desc': 'Pay with ShopeePay'
      },
      // {
      //   'image': 'assets/images/card_icon.png',
      //   'title': 'Card',
      //   'desc': 'Pay with Credit/Debit Card'
      // },
    ];

    showPaymentOptionsModal(
      context: context,
      paymentOptions: paymentOptions,
      selectedValue: _selectedPaymentMethod,
      onSelected: (int value) {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
    );
  }
}
