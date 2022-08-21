import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({Key? key, required this.totalNotifications})
      : super(key: key);

  final int totalNotifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: BaseColor.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          totalNotifications.toString(),
          style: BaseTextStyle.fontFamilyRegular(Colors.white, 20),
        ),
      )),
    );
  }
}
