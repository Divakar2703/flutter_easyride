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
                    SvgPicture.asset(AppImage.filter),
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
                          : ListView.separated(
                              itemCount: v.walletHistoryList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  Divider(height: 0, color: AppColors.black.withOpacity(0.1)),
                              itemBuilder: (context, index) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                // leading: CircleAvatar(radius: 25),
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
}
