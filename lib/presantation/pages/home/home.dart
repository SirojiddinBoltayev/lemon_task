import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lemon_task/constants/app_assets/app_assets.dart';
import 'package:lemon_task/constants/app_colors/app_colors.dart';
import 'package:lemon_task/presantation/component/app_text/app_text.dart';
import 'package:lemon_task/presantation/component/custom_svg.dart';
// import 'package:nfc_manager/nfc_manager.dart';

import '../../../constants/app_source/app_source.dart';
import '../../component/circle_button_container.dart';
import '../../component/credit_card.dart';
import '../../resources/app_navigator.dart';
import 'create_card_screen/nfc_scan_credit_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          AppSource.appName,
          color: AppColors.white,
          fontSize: 28,
        ),
        actions: [
          AppCircleButtonContainer(
              backgroundColor: AppColors.transparent,
              borderColor: AppColors.white,
              icon: AppCustomSvgWidgetAsset(AppAssets.nfcPayIconSvg),
              onPressed: () async {
                AppNavigator.push(NfcScanCreditCard.routeName,
                //     extra: {
                //   "onSuccess": (NfcTag tag) {
                //     AppNavigator.pop();
                //     log("data: ${tag.data.toString()}");
                //     log("handle: ${tag.handle.toString()}");
                //   }
                // }
                );
              }),
          12.sp.horizontalSpace,
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CreditCard(
              status: CardIsEmpty.empty,
            ),
          ],
        ),
      ),
    );
  }
}
