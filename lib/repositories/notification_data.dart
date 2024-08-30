import '../models/notification_model.dart';

List<NotificationModel> notifications = [
  NotificationModel(
    title: "New Update Available",
    date: DateTime.now().subtract(Duration(days: 0)),
    detail: "Version 1.2.0 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "order created success fully",
    date: DateTime.now().subtract(Duration(days: 5)),
    detail: "1 pizza 2 chocolat from burger heven",
  ),
  NotificationModel(
    title: "order on the way",
    date: DateTime.now().subtract(Duration(days: 5)),
    detail: "Version 1.2.0 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "order delivered",
    date: DateTime.now().subtract(Duration(days: 5)),
    detail: "Version 1.2.0 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "payment recived",
    date: DateTime.now().subtract(Duration(days: 5)),
    detail: "Version 1.2.0 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "New ",
    date: DateTime.now().subtract(Duration(days: 9)),
    detail: "Version 1.1.0 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "New Update Available",
    date: DateTime.now().subtract(Duration(days: 31)),
    detail: "Version 1.0.1 is now available with new features and improvements.",
  ),
  NotificationModel(
    title: "order created success fully",
    date: DateTime.now().subtract(Duration(days: 34)),
    detail: "Version 1.0.0 is now available with new features and improvements.",
  ),
];
