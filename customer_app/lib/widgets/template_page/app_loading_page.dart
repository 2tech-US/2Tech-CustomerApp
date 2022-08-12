import 'dart:math';

import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonPage(
        content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset("assets/images/app_logo.png",
                width: min(300, MediaQuery.of(context).size.width * 0.5),
                fit: BoxFit.fitWidth)),
        const CircularProgressIndicator(),
      ],
    ));
  }
}
