import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/profile/provider/profile_provider.dart';
import 'package:flutter_easy_ride/view/profile/ui/ride_history_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RideHistoryScreen extends StatefulWidget {
  RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  RefreshController refreshController = RefreshController(initialRefresh: false);

  ScrollController scrollController = ScrollController();

  void onLoading() async {
    final provider = context.read<ProfileProvider>();
    provider.page += 1;
    await provider.getBookingsHistory();
    if (mounted) {
      refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color: AppColors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  ),
                  Text("Booking History", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox()
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CommonTextField(
                    hintText: "Search",
                    con: context.read<ProfileProvider>().search,
                    height: 38,
                    onEditingComplete: () {
                      context.read<ProfileProvider>().page = 1;
                      context.read<ProfileProvider>().getBookingsHistory();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    cursorHeight: 18,
                    suffix: SvgPicture.asset(AppImage.search),
                    contentPadding: EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                    onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.white,
                          builder: (context) => filterWidget(context),
                        ),
                    child: SvgPicture.asset(AppImage.filter)),
              ],
            ),
          ),
          Consumer<ProfileProvider>(
            builder: (context, v, child) => Expanded(
              child: SmartRefresher(
                onLoading: onLoading,
                enablePullDown: false,
                enablePullUp: v.pullUp,
                controller: refreshController,
                scrollController: scrollController,
                physics: BouncingScrollPhysics(),
                child: v.loadHistory
                    ? Indicator()
                    : v.bookingHistoryList.isEmpty
                        ? Center(child: Text("No history available."))
                        : ListView.separated(
                            controller: scrollController,
                            itemCount: v.bookingHistoryList.length,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            separatorBuilder: (context, index) => SizedBox(height: 15),
                            itemBuilder: (context, index) => HistoryCard(bookingHistory: v.bookingHistoryList[index]),
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  final provider = context.read<ProfileProvider>();
                  provider.startCon.clear();
                  provider.endCon.clear();
                  provider.type = "";
                  provider.page = 1;
                  provider.typeList.forEach((e) => e.isSelected = false);
                  provider.getBookingsHistory();
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.yellowDark),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Reset", style: TextStyle(fontSize: 12, color: AppColors.yellowDark))),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context.read<ProfileProvider>().page = 1;
                  context.read<ProfileProvider>().getBookingsHistory();
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.yellowDark, borderRadius: BorderRadius.circular(10)),
                    child: Text("Apply", style: TextStyle(fontSize: 12, color: AppColors.white))),
              ),
            ],
          ),
          SizedBox(height: 20),
          Consumer<ProfileProvider>(
            builder: (context, v, child) => Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    con: v.startCon,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    hintText: "Start Date",
                    readOnly: true,
                    onTap: () => v.selectStartDate(context, "start"),
                    suffix: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SvgPicture.asset(AppImage.calender),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text("To"),
                SizedBox(width: 5),
                Expanded(
                  child: CommonTextField(
                    con: v.endCon,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    hintText: "End Date",
                    readOnly: true,
                    onTap: () => v.selectStartDate(context, "end"),
                    suffix: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SvgPicture.asset(AppImage.calender),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Transaction Type",
            style: TextStyle(color: AppColors.black.withOpacity(0.8)),
          ),
          SizedBox(height: 15),
          Consumer<ProfileProvider>(
            builder: (context, v, child) => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                v.typeList.length,
                (index) => GestureDetector(
                  onTap: () => v.selectFilter(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: v.typeList[index].isSelected ?? false ? AppColors.yellowDark : Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.black.withOpacity(0.03),
                    ),
                    child: Text(v.typeList[index].title ?? ""),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
