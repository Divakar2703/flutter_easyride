import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/date_formates.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/payments/provider/payment_provider.dart';
import 'package:flutter_easy_ride/view/payments/ui/add_money_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class WalletScreen extends StatefulWidget {
  final bool? backVisible;

  const WalletScreen({super.key, this.backVisible});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<PaymentProvider>().getWalletHistory());
  }

  TextEditingController moneyCon = TextEditingController();
  final _key = GlobalKey<FormState>();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  void onLoading() async {
    context.read<PaymentProvider>().page += 1;
    await context.read<PaymentProvider>().getWalletHistory();
    refreshController.loadComplete();
  }

  late PaymentProvider paymentProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    paymentProvider = context.read<PaymentProvider>();
  }

  @override
  void dispose() {
    paymentProvider.type = "";
    paymentProvider.page = 1;
    paymentProvider.pullUp = true;
    paymentProvider.startCon.clear();
    paymentProvider.endCon.clear();
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
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
                    onTap: () => widget.backVisible ?? false
                        ? Navigator.pop(context)
                        : context.read<BottomBarProvider>().changePage(0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  ),
                  Text("Wallet", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox()
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    border: Border.all(color: AppColors.blue.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 14,
                        color: AppColors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Available Bal:", style: TextStyle(color: AppColors.borderColor.withOpacity(0.7))),
                                Text("₹${context.watch<PaymentProvider>().walletAmount}",
                                    style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_key.currentState?.validate() ?? false) {
                                    final check = await context.read<PaymentProvider>().addMoneyToWallet(moneyCon.text);
                                    if (check) {
                                      context.read<PaymentProvider>().getPaymentGateways();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddMoneyScreen(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(AppImage.pluse),
                                      SizedBox(width: 5),
                                      Text("Add Money"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          con: moneyCon,
                          labelText: "Add Money",
                          validator: FormBuilderValidators.required(errorText: "Please enter amount"),
                          keyBoardType: TextInputType.number,
                          labelStyle: TextStyle(color: AppColors.borderColor.withOpacity(0.8)),
                          suffix: context.watch<PaymentProvider>().moneyAmount != null &&
                                  context.watch<PaymentProvider>().moneyAmount != ""
                              ? GestureDetector(
                                  onTap: () {
                                    moneyCon.clear();
                                    context.read<PaymentProvider>().changeAmount("");
                                  },
                                  child: Icon(Icons.close))
                              : SizedBox.shrink(),
                          onChanged: (v) => context.read<PaymentProvider>().changeAmount(v),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(height: 15),
                        Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 10,
                            spacing: 10,
                            children: ["200", "500", "1000", "2000", "5000"]
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      context.read<PaymentProvider>().changeAmount(e);
                                      moneyCon.text = e;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text("₹${e}"),
                                    ),
                                  ),
                                )
                                .toList())
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("Wallet History", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CommonTextField(
                        height: 38,
                        contentPadding: EdgeInsets.all(5),
                        cursorHeight: 18,
                        suffix: SvgPicture.asset(AppImage.search),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                        onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => filterWidget(),
                            ),
                        child: SvgPicture.asset(AppImage.filter)),
                    SizedBox(width: 10),
                    SvgPicture.asset(AppImage.sort),
                  ],
                ),
                SizedBox(height: 10),
                Consumer<PaymentProvider>(
                  builder: (context, v, child) => v.load
                      ? Indicator()
                      : v.walletHistoryList.isEmpty
                          ? Center(child: Text("Transaction not available."))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: SmartRefresher(
                                enablePullUp: v.pullUp,
                                enablePullDown: false,
                                onLoading: onLoading,
                                controller: refreshController,
                                scrollController: scrollController,
                                physics: BouncingScrollPhysics(),
                                child: ListView.separated(
                                  // shrinkWrap: true,
                                  controller: scrollController,
                                  itemCount: v.walletHistoryList.length,
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      Divider(height: 0, color: AppColors.black.withOpacity(0.1)),
                                  itemBuilder: (context, index) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(v.walletHistoryList[index].description ?? ""),
                                    subtitle: v.walletHistoryList[index].createdAt != null
                                        ? Text(DateFormats.formatDateTime(v.walletHistoryList[index].createdAt ?? ""),
                                            style: TextStyle(fontSize: 12))
                                        : SizedBox.shrink(),
                                    trailing: Text(
                                        "${v.walletHistoryList[index].transactionType == "credit" ? "+" : "-"}₹${v.walletHistoryList[index].amount ?? "0"}",
                                        style: TextStyle(
                                            color: v.walletHistoryList[index].transactionType == "credit"
                                                ? AppColors.green
                                                : AppColors.black,
                                            fontSize: 18)),
                                  ),
                                ),
                              ),
                            ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: widget.backVisible ?? false ? 5 : 80),
        child: CommonButton(
          load: context.watch<PaymentProvider>().addMoneyLoad,
          label: "Add Money Now",
          buttonBorderColor: AppColors.blue,
          buttonColor: AppColors.blue,
          labelColor: AppColors.white,
          onPressed: () async {
            if (_key.currentState?.validate() ?? false) {
              final check = await context.read<PaymentProvider>().addMoneyToWallet(moneyCon.text);
              if (check) {
                context.read<PaymentProvider>().getPaymentGateways();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMoneyScreen(),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget filterWidget() {
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
                  final provider = context.read<PaymentProvider>();
                  provider.startCon.clear();
                  provider.endCon.clear();
                  provider.type = "";
                  provider.page = 1;
                  provider.typeList.forEach((e) => e.isSelected = false);
                  provider.getWalletHistory();

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
                  context.read<PaymentProvider>().page = 1;
                  context.read<PaymentProvider>().getWalletHistory();
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
          Consumer<PaymentProvider>(
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
          Consumer<PaymentProvider>(
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
                          color: v.typeList[index].isSelected ?? false ? AppColors.yellow : Colors.transparent),
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
