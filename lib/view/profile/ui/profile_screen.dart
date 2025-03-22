import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/utils/local_storage.dart';
import 'package:flutter_easy_ride/view/authentication/ui/login_screen.dart';
import 'package:flutter_easy_ride/view/components/common_button.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/horizontal_image_text.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:flutter_easy_ride/view/profile/provider/profile_provider.dart';
import 'package:flutter_easy_ride/view/profile/ui/ride_history_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile();
      context.read<ProfileProvider>().getSavedAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onTap: () => context.read<BottomBarProvider>().changePage(0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
                Text("Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox()
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Consumer<ProfileProvider>(
                    builder: (context, v, child) => v.load
                        ? ListView.separated(
                            itemCount: 3,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withOpacity(0.1),
                                      offset: Offset(0, 2),
                                      blurRadius: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      v.profileDataModel?.name ?? "",
                                      style: TextStyle(
                                          color: AppColors.borderColor, fontWeight: FontWeight.w500, fontSize: 22),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        name.text = v.profileDataModel?.name ?? "";
                                        phone.text = v.profileDataModel?.mobile ?? "";
                                        email.text = v.profileDataModel?.email ?? "";
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialog(
                                            insetPadding: EdgeInsets.zero,
                                            titlePadding: EdgeInsets.only(top: 15),
                                            title: Center(
                                              child: Text("Update Profile",
                                                  style: TextStyle(
                                                      color: AppColors.borderColor, fontWeight: FontWeight.bold)),
                                            ),
                                            content: Container(
                                              width: MediaQuery.of(context).size.width - 75,
                                              child: Form(
                                                key: _key,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CommonTextField(
                                                      labelText: "Name",
                                                      con: name,
                                                      validator: FormBuilderValidators.required(
                                                          errorText: "Please enter name"),
                                                    ),
                                                    SizedBox(height: 10),
                                                    CommonTextField(
                                                      labelText: "Mobile Number",
                                                      con: phone,
                                                      validator: FormBuilderValidators.compose([
                                                        FormBuilderValidators.required(
                                                            errorText: "Please enter mobile number"),
                                                        FormBuilderValidators.minLength(10,
                                                            errorText: "Please enter minimum 10 number"),
                                                      ]),
                                                    ),
                                                    SizedBox(height: 10),
                                                    CommonTextField(
                                                      labelText: "Email",
                                                      con: email,
                                                      validator: FormBuilderValidators.compose([
                                                        FormBuilderValidators.required(
                                                            errorText: "Please enter mobile number"),
                                                        FormBuilderValidators.email(
                                                            errorText: "Please enter valid email"),
                                                      ]),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CommonButton(
                                                            label: "Cancel",
                                                            labelColor: AppColors.black,
                                                            buttonColor: Colors.transparent,
                                                            onPressed: () => Navigator.pop(context),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: CommonButton(
                                                            label: "Update",
                                                            onPressed: () {
                                                              if (_key.currentState?.validate() ?? false) {
                                                                v.updateProfile(
                                                                    email: email.text,
                                                                    name: name.text,
                                                                    phone: int.parse(phone.text));
                                                                name.clear();
                                                                phone.clear();
                                                                email.clear();
                                                                Navigator.pop(context);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(AppImage.editSvg)),
                                ],
                              ),
                              SizedBox(height: 20),
                              HorizontalImageText(image: AppImage.call, title: v.profileDataModel?.mobile ?? ""),
                              Divider(color: AppColors.black.withOpacity(0.1), height: 20),
                              HorizontalImageText(image: AppImage.email, title: v.profileDataModel?.email ?? ""),
                            ],
                          ),
                  ),
                  Divider(color: AppColors.black.withOpacity(0.1), height: 20),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.black.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Saved Address",
                          style: TextStyle(color: AppColors.borderColor, fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        context.watch<ProfileProvider>().addressList.isEmpty ? SizedBox.shrink() : SizedBox(height: 20),
                        Consumer<ProfileProvider>(
                          builder: (context, v, child) => v.loadAddress
                              ? ListView.separated(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => SizedBox(height: 10),
                                  itemBuilder: (context, index) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black.withOpacity(0.1),
                                            offset: Offset(0, 2),
                                            blurRadius: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: v.addressList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      Divider(color: AppColors.black.withOpacity(0.1)),
                                  itemBuilder: (context, index) => HorizontalImageText(
                                    isAddress: true,
                                    image: v.addressList[index].type?.toLowerCase() == "home"
                                        ? AppImage.homeSvg
                                        : v.addressList[index].type?.toLowerCase() == "office"
                                            ? AppImage.officeSvg
                                            : AppImage.location,
                                    titleColor: AppColors.borderColor,
                                    title: v.addressList[index].type,
                                    subTitle: v.addressList[index].address,
                                    onDeleteAddressTap: () => v.deleteAddress(
                                      id: int.parse(v.addressList[index].id ?? "0"),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SafeArea(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Add New Address",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Divider(color: AppColors.borderColor.withOpacity(0.2)),
                                        SizedBox(height: 10),
                                        Text(
                                          "Address Type",
                                          style: TextStyle(
                                              color: AppColors.borderColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5),
                                        Consumer<ProfileProvider>(
                                          builder: (context, v, child) => SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(
                                                v.addressTypeList.length,
                                                (i) => Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () => v.changeAddressType(i),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: v.addressTypeList[i].isSelected ?? false
                                                                  ? AppColors.yellowDark
                                                                  : AppColors.borderColor.withOpacity(0.5)),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          SvgPicture.asset(v.addressTypeList[i].image ?? "",
                                                              width: 20, height: 20),
                                                          SizedBox(width: 5),
                                                          Text(v.addressTypeList[i].title ?? ""),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ).toList(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CommonTextField(
                                          con: address,
                                          headerLabel: "Address",
                                          hintStyle: TextStyle(
                                              color: AppColors.borderColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                          onChanged: (v) => context.read<ProfileProvider>().searchLocation(v),
                                        ),
                                        Consumer<ProfileProvider>(
                                          builder: (context, v, child) =>
                                              SizedBox(height: v.placesList.isNotEmpty ? 25 : 225),
                                        ),
                                        Consumer<ProfileProvider>(
                                          builder: (context, v, child) => ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: v.placesList.length,
                                            itemBuilder: (context, index) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: SvgPicture.asset(AppImage.loc),
                                                  title: Text(v.placesList[index].placePrediction?.text?.text ?? ""),
                                                  onTap: () {
                                                    address.text =
                                                        v.placesList[index].placePrediction?.text?.text ?? "";
                                                    context.read<ProfileProvider>().updateList();
                                                  },
                                                ),
                                                Divider(height: 0, color: AppColors.borderColor.withOpacity(0.2))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonButton(
                                                label: "Cancel",
                                                labelColor: AppColors.black,
                                                buttonColor: Colors.transparent,
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CommonButton(
                                                label: "Add",
                                                onPressed: () {
                                                  context.read<ProfileProvider>().addAddress(address: address.text);
                                                  address.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppImage.pluse),
                                  SizedBox(width: 3),
                                  Text(
                                    "Add New",
                                    style: TextStyle(color: AppColors.black.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.black.withOpacity(0.1)),
                    ),
                    child: HorizontalImageText(
                      image: AppImage.setting,
                      title: "Account Setting",
                      titleColor: AppColors.borderColor,
                      titleFontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RideHistoryScreen())),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.black.withOpacity(0.1)),
                      ),
                      child: HorizontalImageText(
                        image: AppImage.setting,
                        title: "Ride History",
                        titleColor: AppColors.borderColor,
                        titleFontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await LocalStorage.clearPref();
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                    },
                    child: HorizontalImageText(
                      title: "Logout",
                      viewIcon: true,
                      titleFontSize: 16,
                      image: AppImage.logout,
                      titleColor: AppColors.redColor,
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
