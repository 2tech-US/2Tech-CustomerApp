import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';

class CustomBtnAlertDialog extends StatelessWidget {
  const CustomBtnAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.context,
      required this.buttonTitle})
      : super(key: key);

  final BuildContext context;
  final String title;
  final String content;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: BaseTextStyle.fontFamilyBold(Colors.black, 18)),
      content:
          Text(content, style: BaseTextStyle.fontFamilyRegular(Colors.black, 16)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        TextButton(
            child: Text(buttonTitle,
                style: BaseTextStyle.fontFamilySemiBold(Colors.red, 16)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
