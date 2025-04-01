import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/notification/models/notification_response.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notifications> _notifications = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                blurRadius: 14,
                color: AppColors.black.withOpacity(0.1),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SafeArea(
            child: Center(
                child: Text("Notifications",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ),
        _notifications.isEmpty
            ? Expanded(
                child: Center(
                  child: Text(
                    'No Notifications.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15),
                  itemCount: _notifications.length + 1,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderColor)),
                        child: SvgPicture.asset(AppImage.box)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 2,
                            child: Text(_notifications[index].rideStatus)),
                        SizedBox(width: 8),
                        Expanded(child: Text("•Just Now")),
                      ],
                    ),
                    subtitle: Text(
                      _notifications[index].bookingType,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.borderColor.withOpacity(0.8)),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
