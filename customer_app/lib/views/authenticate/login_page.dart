import 'dart:math';
import 'package:customer_app/views/authenticate/register_information_page.dart';
import 'package:customer_app/views/authenticate/register_phone_page.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/base_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _phoneError;
  String? _passwordError;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
        content: Stack(children: [
      SingleChildScrollView(
          child: Container(
              width: safeWidth,
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildLogoArea(heightSafeArea, safeWidth, keyboardHeight),
                    const SizedBox(height: 20.0),
                    buildLoginArea(heightSafeArea, context, keyboardHeight)
                  ]))),
      Container(
          alignment: Alignment.bottomCenter,
          child: buildRegisterArea(heightSafeArea, keyboardHeight))
    ]));
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
            height: 100,
            width: safeWidth * 0.6, fit: BoxFit.fitHeight));
  }

  Widget buildLoginArea(
      double heightSafeArea, BuildContext context, double keyboardHeight) {
    return SizedBox(
        height: heightSafeArea * 0.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          CustomTextField.common(
              onChanged: (value) {
                _clearError();
              },
              errorText: _phoneError,
              textEditingController: _phoneController,
              hintText: "Nhập số điện thoại",
              required: true,
              labelText: "Số điện thoại",
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next),
          const SizedBox(height: 16),
          CustomTextField.common(
            onChanged: (value) {
              _clearError();
            },
            errorText: _passwordError,
            textEditingController: _passwordController,
            hintText: "********",
            labelText: "Mật khẩu",
            required: true,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            isVisibility: true,
          ),
          const SizedBox(height: 16),
          Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {},
                  child: Text("Quên mật khẩu?",
                      style: BaseTextStyle.fontFamilySemiBold(
                          BaseColor.primary, 14)))),
          AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: (keyboardHeight == 0) ? 32 : 16),
          CustomButton.common(onTap: () {}, content: "Đăng Nhập"),
        ]));
  }

  Widget buildRegisterArea(double heightSafeArea, double keyboardHeight) {
    return SizedBox(
        height: (keyboardHeight == 0) ? 200 : 0,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            "Bạn chưa có tài khoản?",
            style: BaseTextStyle.fontFamilyRegular(Colors.black, 14),
          ),
          TextButton(
              child: Text("Đăng ký ngay",
                  style:
                      BaseTextStyle.fontFamilySemiBold(BaseColor.primary, 14)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPhonePage()));
              }),
        ]));
  }

  void _clearPassword() {
    _passwordController.clear();
  }

  void _clearError() {
    setState(() {
      _phoneError = null;
      _passwordError = null;
    });
  }
}
