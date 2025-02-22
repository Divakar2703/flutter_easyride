import 'package:flutter/material.dart';

import '../../model/notification_response.dart';
import 'notification_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: _notifications.isEmpty && !_isLoading
          ? Center(child: Text('No Notifications'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _notifications.length + 1,
              itemBuilder: (context, index) {
                if (index == _notifications.length) {
                  return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
                }
                final notification = _notifications[index];
                return ListTile(
                  title: Text(notification.rideStatus),
                  subtitle: Text(notification.bookingType),
                );
              },
            ),
    );
  }
}
