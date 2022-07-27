import 'dart:math';
import 'package:customer_app/views/authenticate/otp_register_page.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/base_constant.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({Key? key}) : super(key: key);

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePage();
}

class _RegisterPhonePage extends State<RegisterPhonePage> {
  String? _phoneError;
  final _phoneController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    return CommonPage(
      content: SingleChildScrollView(
        child: Container(
          width: safeWidth,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildLogoArea(heightSafeArea, safeWidth, keyboardHeight),
                const SizedBox(height: 20.0),
                buildPhoneInputArea(heightSafeArea, context, keyboardHeight)
              ]),
        ),
      ),
    );
  }

  Widget buildLogoArea(
      double heightSafeArea, double safeWidth, double keyboardHeight) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        height: (keyboardHeight == 0)
            ? heightSafeArea * 0.3
            : heightSafeArea * 0.15,
        child: Image.asset("assets/images/app_logo.png",
            height: 100, width: safeWidth * 0.6, fit: BoxFit.fitHeight));
  }

  Widget buildPhoneInputArea(
      double heightSafeArea, BuildContext context, double keyboardHeight) {
    return SizedBox(
        height: heightSafeArea * 0.7,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Đi khắp nơi cùng 2Tech!',
                  style: BaseTextStyle.fontFamilyBold(BaseColor.primary, 22)),
              const SizedBox(height: 10.0),
              Text('Đăng ký tài khoản ngay bây giờ',
                  style: BaseTextStyle.fontFamilyRegular(Colors.black54, 16)),
              const SizedBox(height: 20.0),
              CustomTextField.common(
                  onChanged: (value) {
                    _clearError();
                  },
                  errorText: _phoneError,
                  textEditingController: _phoneController,
                  hintText: "Nhập số điện thoại",
                  required: true,
                  isPrefix: true,
                  labelText: "Số điện thoại",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next),
              const SizedBox(height: 80.0),
              Row(children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(BaseColor.primary),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                        style:
                            BaseTextStyle.fontFamilyRegular(Colors.black, 14),
                        children: [
                          const TextSpan(text: "Tôi đồng ý với tất cả "),
                          TextSpan(
                              text: "Điều kiện và Điều khoản ",
                              style: BaseTextStyle.fontFamilyRegular(
                                  BaseColor.primary, 14)),
                          const TextSpan(text: "của "),
                          TextSpan(
                              text: "2Tech.",
                              style: BaseTextStyle.fontFamilyBold(
                                  Colors.black, 14)),
                        ]),
                  ),
                ),
              ]),
              const SizedBox(height: 20.0),
              CustomButton.common(
                onTap: () {
                  if (isChecked) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OTPRegisterPage(),
                      ),
                    );
                  } else {
                    setState(() {
                      _phoneError =
                          "Bạn phải đồng ý với điều khoản và điều kiện của 2Tech";
                    });
                  }
                },
                content: "Tiếp tục",
              ),
              const SizedBox(height: 8.0),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: const Icon(Icons.arrow_back,
                      size: 15, color: Color.fromRGBO(0, 51, 153, 1)),
                  label: Text("Trở về trang đăng nhập",
                      style: BaseTextStyle.fontFamilySemiBold(
                          BaseColor.primary, 14)))
            ]));
  }

  void _clearError() {
    setState(() {
      _phoneError = null;
    });
  }
}
