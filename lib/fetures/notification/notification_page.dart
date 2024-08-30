import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import '../../repositories/notification_data.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  Map<String, List<NotificationModel>> groupNotificationsByDate(List<NotificationModel> notifications) {
    Map<String, List<NotificationModel>> groupedNotifications = {};

    for (var notification in notifications) {
      String dateString = DateFormat('yyyy-MM-dd').format(notification.date);
      if (groupedNotifications.containsKey(dateString)) {
        groupedNotifications[dateString]!.add(notification);
      } else {
        groupedNotifications[dateString] = [notification];
      }
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    var groupedNotifications = groupNotificationsByDate(notifications);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: groupedNotifications.length,
        itemBuilder: (context, index) {
          String date = groupedNotifications.keys.elementAt(index);
          List<NotificationModel> dailyNotifications = groupedNotifications[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('MMMM dd, yyyy').format(DateTime.parse(date)),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...dailyNotifications.map((notification) => NotificationTile(notification: notification)).toList(),
            ],
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  final NotificationModel notification;

  const NotificationTile({Key? key, required this.notification}) : super(key: key);

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade50, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.notification.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              DateFormat('hh:mm a').format(widget.notification.date),
              style: TextStyle(color: Colors.grey[700]),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.orangeAccent,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.notification.detail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
