import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/indicator.dart';

import '../models/notification_response.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Notifications> _notifications = [];
  int _currentPage = 1;
  final int _limit = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      _notifications = await NotificationService().fetchNotifications(_currentPage, _limit);
      setState(() {
        _currentPage++;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            child: Center(child: Text("Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ),
        _isLoading
            ? Expanded(child: Indicator())
            : _notifications.isEmpty
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
                      controller: _scrollController,
                      itemCount: _notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _notifications.length) {
                          return SizedBox.shrink();
                        }
                        final notification = _notifications[index];
                        return ListTile(
                          title: Text(notification.rideStatus),
                          subtitle: Text(notification.bookingType),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}
