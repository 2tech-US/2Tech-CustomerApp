import 'dart:math';

import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/views/authenticate/login_page.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      content: buildSlideView(context),
    );
  }

  Widget buildSlideView(BuildContext context) {
    const actionAreaHeight = 64.0;
    return SafeArea(
        child: IntroductionScreen(
            globalBackgroundColor: Colors.transparent,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            showNextButton: false,
            showDoneButton: true,
            dotsDecorator: const DotsDecorator(
                color: Colors.transparent, activeColor: Colors.transparent),
            done: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 51, 153, 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bắt đầu",
                      style:
                          BaseTextStyle.fontFamilySemiBold(Colors.white, 14)),
                  const SizedBox(width: 2),
                  const Expanded(
                      child: Icon(Icons.arrow_forward,
                          color: Colors.white, size: 18)),
                ],
              ),
            ),
            rawPages: [
          buildContentArea(
              context,
              actionAreaHeight,
              'assets/images/app_lgo.png',
              'assets/images/welcome.png',
              'Chào mừng bạn đến với 2Tech!'),
        ]));
  }

  Widget buildContentArea(BuildContext context, double actionAreaHeight,
      [String? logoUrl, String? imgUrl, String? title]) {
    return Container(
        margin: EdgeInsets.only(bottom: actionAreaHeight),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset("assets/images/app_logo.png",
              width: min(230, MediaQuery.of(context).size.width * 0.5),
              fit: BoxFit.fitWidth),
          Image.asset(imgUrl!,
              width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
          SizedBox(
            width: min(450, MediaQuery.of(context).size.width - 64),
            child: Center(
              child: Text(title ?? "",
                  style: BaseTextStyle.fontFamilyBold(
                      const Color.fromRGBO(0, 51, 153, 1), 18)),
            ),
          )
        ]));
  }
}
