import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/viewModel/location_view_model.dart';
import 'package:re_empties/features/send_empties/widget/user_location_card.dart';
import 'package:re_empties/features/send_empties/widget/waste_location_dart.dart';

class LocationView extends StatelessWidget {
  LocationView({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<LocationVM>(LocationVM.new);

  final AutoDisposeChangeNotifierProvider<LocationVM> _viewModel;

  @override
  Widget build(BuildContext context) => BaseView(
        provider: _viewModel,
        appBar: (_) => CustomAppBar(
          title: Text( 'Set Your Location', style: textTheme.appbarTitle),
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
              Row(
                children: [
                  ImageAsset(
                    imagePath: images.location,
                    height: 90.h,
                    width: 26.w,
                  ),
                  Gap(5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hint: 'Search your location...',
                          controller: vm.userController,
                          isMultiline: false,
                          filledColor: colors.yellow3,
                          onTap: () => vm.toggleShowLocations(),
                          onSubmit: (value) {},
                        ),
                        Gap(16.h),
                        CustomTextField(
                          hint: 'Search waste station...',
                          controller: vm.stationController,
                          isMultiline: false,
                          filledColor: colors.green6,
                          onTap: () => vm.toggleShowWasteStations(),
                          onSubmit: (value) {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Gap(25.h),
              Divider(height: 1.h, color: colors.gray4),
              Gap(16.h),
              Expanded(
                child: ListView.separated(
                  itemCount: vm.showLocations
                      ? vm.locations.length
                      : vm.wasteStations.length,
                  separatorBuilder: (_, __) => Gap(8.h),
                  itemBuilder: (context, index) {
                    if (vm.showLocations) {
                      final location = vm.locations[index];
                      return UserLocationCard(
                        title: location.name,
                        address: location.address,
                        isSelected: vm.selectedLocation == location.name,
                        onTap: () => vm.selectLocation(location.name),
                      );
                    } else {
                      final station = vm.wasteStations[index];
                      return WasteLocationCard(
                        title: station.name,
                        address: station.address,
                        openHour: station.openHour,
                        isSelected: vm.selectedWasteStation == station.name,
                        onTap: () => vm.selectWasteStation(station.name),
                        distance: station.distance,
                      );
                    }
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
              // Handle location selection
            },
          ),
        ),
      );
}
