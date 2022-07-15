import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static Widget common({required VoidCallback onTap, required String content}) {
    return InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: BaseColor.primary,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ]),
            child: Text(content,
                style: BaseTextStyle.fontFamilyBold(Colors.white, 16))));
  }

  static Widget small({required VoidCallback onTap, required String content}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: BaseColor.primary,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ]),
            child: Text(content,
                style: BaseTextStyle.fontFamilySemiBold(Colors.white, 14))));
  }

  static Widget withIcon(
      {required VoidCallback onTap,
      required String content,
      required String iconPath}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 51, 153, 1),
            borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Text(content,
                style: BaseTextStyle.fontFamilyBold(Colors.white, 16)),
          ],
        ),
      ),
    );
  }
}
