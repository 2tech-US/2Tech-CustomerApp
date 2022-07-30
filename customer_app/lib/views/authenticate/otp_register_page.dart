import 'dart:math';

import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/views/authenticate/login_page.dart';
import 'package:customer_app/views/authenticate/register_information_page.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/otp_option/otp_option.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';

class OTPRegisterPage extends StatefulWidget {
  const OTPRegisterPage({Key? key}) : super(key: key);

  @override
  State<OTPRegisterPage> createState() => _OTPRegisterPageState();
}

class _OTPRegisterPageState extends State<OTPRegisterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);

    return CommonPage(
      content: SingleChildScrollView(
        child: Container(
          width: safeWidth,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: heightSafeArea * 0.2,
                child: Image.asset(
                  "assets/images/app_logo.png",
                  width: safeWidth * 0.5,
                  height: 70,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: heightSafeArea * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đăng ký',
                      style: BaseTextStyle.fontFamilyBold(Colors.black, 17),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nhập mã code được gửi tới điện thoại của bạn',
                      style: BaseTextStyle.fontFamilyRegular(Colors.black, 15),
                    ),
                    const SizedBox(height: 32),
                    const Center(child: OTPOption(otpNum: 4)),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Thay đổi số điện thoại',
                        style: BaseTextStyle.fontFamilySemiBold(
                            BaseColor.primary, 15),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Gửi lại mã code',
                        style:
                            BaseTextStyle.fontFamilySemiBold(Colors.black, 15),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    CustomButton.common(
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      content: "Xác nhận",
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => route.isFirst);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 15,
                        color: BaseColor.primary,
                      ),
                      label: Text("Trở về trang đăng nhập",
                          style: BaseTextStyle.fontFamilySemiBold(
                              BaseColor.primary, 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
