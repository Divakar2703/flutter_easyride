import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/audio_call/web_rtc_service_provider.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatelessWidget {
  final String userID;
  BottomBarScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    Provider.of<WebRTCProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          context.read<BottomBarProvider>().pages[context.watch<BottomBarProvider>().selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: AppColors.yellowCyan, borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  InkWell(
                      onTap: () => context.read<BottomBarProvider>().changePage(0),
                      child: SvgPicture.asset(context.watch<BottomBarProvider>().selectedIndex == 0
                          ? AppImage.selectedHome
                          : AppImage.homeSvg)),
                  Spacer(),
                  InkWell(
                      onTap: () => context.read<BottomBarProvider>().changePage(1),
                      child: SvgPicture.asset(context.watch<BottomBarProvider>().selectedIndex == 1
                          ? AppImage.selectedWallet
                          : AppImage.wallet)),
                  Spacer(),
                  InkWell(
                      onTap: () => context.read<BottomBarProvider>().changePage(2),
                      child: SvgPicture.asset(context.watch<BottomBarProvider>().selectedIndex == 2
                          ? AppImage.selectedNotification
                          : AppImage.notification)),
                  Spacer(),
                  InkWell(
                      onTap: () => context.read<BottomBarProvider>().changePage(3),
                      child: SvgPicture.asset(context.watch<BottomBarProvider>().selectedIndex == 3
                          ? AppImage.selectedProfile
                          : AppImage.profile)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
