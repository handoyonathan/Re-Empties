import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/viewModel/location_view_model.dart';
import 'package:re_empties/features/send_empties/widget/location_card.dart';

class LocationView extends StatelessWidget {
  LocationView({super.key})
      : _viewModel = ChangeNotifierProvider.autoDispose<LocationVM>(
          LocationVM.new,
        );

  final AutoDisposeChangeNotifierProvider<LocationVM> _viewModel;

  @override
  Widget build(BuildContext context) => BaseView(
        provider: _viewModel,
        appBar: (_) => CustomAppBar(
          title: Text(
            'Set Your Location',
            style: textTheme.appbarTitle,
          ),
        ),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, LocationVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: const Center(child: Text("Map Placeholder")),
              ),
              Gap(16.h),
              CustomTextField(
                hint: 'Search your location...',
                controller: vm.stationController,
                onSubmit: (value) {},
                isMultiline: false,
                filledColor: colors.yellow3,
              ),
              Gap(16.h),
              CustomTextField(
                hint: 'Search waste station...',
                controller: vm.stationController,
                onSubmit: (value) {},
                isMultiline: false,
                filledColor: colors.green6,
              ),
              Gap(25.h),
              Divider(height: 1.h, color: colors.gray4,),
              Gap(16.h),
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (_, __) => Gap(8.h),
                  itemBuilder: (context, index) {
                    return LocationCard(
                      title: 'Binus University Kampus Anggrek',
                      address:
                          'Jl. Raya Kb. Jeruk No.27, RT.1/RW.9, Kemanggisan, Kec. Palmerah, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530',
                      isSelected: index == 0,
                      onTap: () {
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: colors.bgColor,
          alignment: Alignment.center,
          height: 70.h,
          child: AppMainButton(
            state: ButtonState.primary,
            text: 'Choose this location',
            onPressed: () {
            },
          ),
        ),
      );
}
