import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class VoucherDetailPageView extends StatefulWidget {
  const VoucherDetailPageView({super.key});

  @override
  State<VoucherDetailPageView> createState() => _VoucherDetailPageViewState();
}

class _VoucherDetailPageViewState extends State<VoucherDetailPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  OverlayEntry? _overlayEntry;

  final List<String> termsAndConditions = [
    "You can use this at any Brewed Awakenings location.",
    "Only one voucher can be used per purchase.",
    "This voucher can't be used with other discounts.",
    "It expires 30 days after you redeem it."
  ];

  final List<String> howToRedeem = [
    "Visit any Brewed Awakenings location.",
    "Show the voucher code to the cashier.",
    "Enjoy your free cup of coffee!"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add the chevron button to the overlay when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addChevronButtonToOverlay();
    });
  }

  @override
  void dispose() {
    // Remove the chevron button from the overlay when the page is disposed
    _removeChevronButtonFromOverlay();
    super.dispose();
  }

  // Function to add chevron button to the overlay
  void _addChevronButtonToOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 16.0.w,
        top: 45.0.h, // Adjust as needed for positioning
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigate back when pressed
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_left,
              color: colors.green1,
              size: 24.0, // Adjust size as needed
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  // Function to remove chevron button from the overlay
  void _removeChevronButtonFromOverlay() {
    _overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top image
          Image.asset(
            images.voucherCoffee, // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250.0, // Adjust this height as needed
          ),
          // Main content follows here...
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Free Shipping on Orders Over Rp30.000",
                          style: textTheme.title,
                        ),
                        Gap(4.h),
                        Text(
                          "Enjoy free shipping on orders over Rp100.000 at MegaShop.",
                          style: textTheme.badgesText,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: colors.gray6,
                    height: 8.0.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          controller: _tabController,
                          indicatorColor: colors.textButton,
                          labelColor: colors.green1,
                          unselectedLabelColor: colors.gray5,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: "Terms & Condition"),
                            Tab(text: "How to Redeem"),
                          ],
                        ),
                        SizedBox(
                          height: 120.0.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Terms & Condition Content
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: termsAndConditions.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "${index + 1}. ${termsAndConditions[index]}",
                                      style: textTheme.badgesText,
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: howToRedeem.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "${index + 1}. ${howToRedeem[index]}",
                                      style: textTheme.badgesText,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: colors.gray6,
                    height: 8.0.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Voucher Code',
                            style: textTheme.detailDropPointLabel,
                          ),
                          Text(
                            'BLU092024',
                            style: textTheme.voucherCode,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: colors.gray6,
                    height: 8.0.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.textButton,
                          size: 18.0,
                        ),
                        Gap(4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Important Notes',
                                style: textTheme.subtitle2,
                              ),
                              Text(
                                'Don\'t slide the voucher before exchanging it – once slid, it\'s gone forever!',
                                style: textTheme.badgesText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom button stays fixed
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: AppMainButton(
              state: ButtonState.primary,
              text: 'Complete',
              onPressed: () {
                print('Primary button pressed');
              },
            ),
          ),
        ],
      ),
    );
  }
}
