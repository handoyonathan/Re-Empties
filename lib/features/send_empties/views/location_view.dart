import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/custom_text_field.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/loading_indicator.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/admin/widget/filter_button.dart';
import 'package:re_empties/features/send_empties/viewModel/location_view_model.dart';
import 'package:re_empties/features/send_empties/widget/waste_location_dart.dart';

class LocationView extends ConsumerStatefulWidget {
  final bool isSend;
  LocationView({super.key, required this.isSend})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<LocationVM>(LocationVM.new);

  final AutoDisposeChangeNotifierProvider<LocationVM> _viewModel;

  @override
  ConsumerState createState() => LocationViewState();
}

class LocationViewState extends ConsumerState<LocationView> {
  @override
  Widget build(BuildContext context) => BaseView(
        provider: widget._viewModel,
        appBar: (_) => CustomAppBar(
          title: Text('Choose your nearest waste location',
              style: textTheme.appbarTitle),
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
                child: vm.userPosition != null
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: vm.userPosition!,
                          zoom: 14.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: vm.onMapCreated,
                      )
                    : const Center(
                        child: LoadingIndicator(),
                      ),
              ),
              Gap(16.h),
              Row(
                children: [
                  ImageAsset(
                    imagePath: images.location,
                    height: 95.h,
                    width: 26.w,
                    fit: BoxFit.fill,
                  ),
                  Gap(5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors.yellow3,
                            border: Border.all(
                              color: colors.yellow1,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: Center(
                              child: Text(vm.userController.text,
                                  style: textTheme.introLabel),
                            ),
                          ),
                        ),
                        Gap(16.h),
                        CustomTextField(
                          hint: 'Search waste station...',
                          controller: vm.stationController,
                          isMultiline: false,
                          filledColor: colors.green6,
                          borderColor: colors.green1,
                          onTap: () => vm.fetchWasteStations(),
                          onChanged: (value) =>
                              vm.onStationSearchChanged(value),
                          onSubmit: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Divider(height: 1.h, color: colors.gray4),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FilterButton(
                    label: 'All',
                    isSelected: vm.selectedFilter == 'All',
                    onTap: () => vm.setFilter('All'),
                  ),
                  Gap(8.w),
                  FilterButton(
                    label: 'Collaboration Waste Station',
                    isSelected: vm.selectedFilter == 'Collab',
                    onTap: () => vm.setFilter('Collab'),
                  ),
                ],
              ),
              Gap(16.h),
              Expanded(
                child: vm.isWasteLocationChanged
                    ? (vm.queriedWasteStations.isEmpty
                        ? Center(
                            child: Text(
                              'Waste Station not Found',
                              style: textTheme.appbarTitle.copyWith(color: colors.gray3),
                            ),
                          )
                        : ListView.separated(
                            itemCount: vm.queriedWasteStations.length,
                            separatorBuilder: (_, __) => Gap(8.h),
                            itemBuilder: (context, index) {
                              final station = vm.queriedWasteStations[index];
                              final isCollab = vm.queriedWasteStations[index].isCollaborator;
                              print(isCollab);
                              return WasteLocationCard(
                                title:  station.stationName,
                                address: station.addressStation,
                                openHour: station.openHours,
                                isSelected: vm.selectedStationId == station.id,
                                isCollab: isCollab,
                                onTap: () {
                                  vm.selectWasteStation(station.id);
                                },
                                distance: station.distance != null
                                    ? '${station.distance!.toStringAsFixed(2)} km'
                                    : 'Calculating...',
                              );
                            },
                          ))
                    : (vm.wasteStations.isEmpty
                        ? Center(
                            child: Text(
                              'Waste Station not Found',
                              style: textTheme.appbarTitle.copyWith(color: colors.gray3),
                            ),
                          )
                        : ListView.separated(
                            itemCount: vm.wasteStations.length,
                            separatorBuilder: (_, __) => Gap(8.h),
                            itemBuilder: (context, index) {
                              final station = vm.wasteStations[index];
                              final isCollab = vm.wasteStations[index].isCollaborator;
                              return WasteLocationCard(
                                title: station.stationName,
                                address: station.addressStation,
                                openHour: station.openHours,
                                isSelected: vm.selectedStationId == station.id,
                                isCollab: isCollab,
                                onTap: () {
                                  vm.selectWasteStation(station.id);
                                },
                                distance: station.distance != null
                                    ? '${station.distance!.toStringAsFixed(2)} km'
                                    : 'Calculating...',
                              );
                            },
                          )),
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
            text: 'Choose this waste station',
            onPressed: () {
              vm.goToFormPage(isSend: widget.isSend);
            },
          ),
        ),
      );
}
