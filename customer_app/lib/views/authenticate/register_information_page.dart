import 'dart:math';
import 'package:customer_app/cubit/authentication/authentication_cubit.dart';
import 'package:customer_app/logic/authentication_logic.dart';
import 'package:customer_app/models/authenticaton/authentication_model.dart';
import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/views/authenticate/login_page.dart';
import 'package:customer_app/views/authenticate/register_phone_page.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterInformationPage extends StatefulWidget {
  const RegisterInformationPage({Key? key}) : super(key: key);

  @override
  State<RegisterInformationPage> createState() =>
      _RegisterInformationPageState();
}

class _RegisterInformationPageState extends State<RegisterInformationPage> {
  String? _nameError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    return CommonPage(
        content: SingleChildScrollView(
            child: Container(
                width: safeWidth,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildLogoArea(heightSafeArea, safeWidth),
                      const SizedBox(height: 50.0),
                      buildRegisterArea(context)
                    ]))));
  }

  Widget buildLogoArea(double heightSafeArea, double safeWidth) {
    return Container(
        alignment: Alignment.bottomCenter,
        height: heightSafeArea * 0.15,
        child: Image.asset("assets/images/app_logo.png",
            height: 100, width: safeWidth * 0.6, fit: BoxFit.fitHeight));
  }

  Widget buildRegisterArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Thông tin tài khoản",
          style: BaseTextStyle.fontFamilyBold(Colors.black, 16)),
      const SizedBox(height: 16),
      CustomTextField.common(
          onChanged: (value) {
            _clearError();
          },
          textEditingController: _nameController,
          errorText: _nameError,
          labelText: "Tên đăng nhập",
          hintText: "Nhập tên của bạn",
          required: true,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next),
      const SizedBox(height: 16),
      CustomTextField.common(
          onChanged: (value) {
            _clearError();
          },
          textEditingController: _usernameController,
          errorText: _usernameError,
          labelText: "Địa chỉ",
          hintText: "Nhập địa chỉ của bạn",
          required: true,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next),
      const SizedBox(height: 16),
      CustomTextField.common(
          onChanged: (value) {
            _clearError();
          },
          textEditingController: _passwordController,
          errorText: _passwordError,
          labelText: "Mật khẩu",
          hintText: "********",
          required: true,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          isVisibility: true),
      const SizedBox(height: 16),
      CustomTextField.common(
          onChanged: (value) {
            _clearError();
          },
          textEditingController: _confirmPasswordController,
          errorText: _confirmPasswordError,
          labelText: "Nhập lại mật khẩu",
          hintText: "********",
          required: true,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.done,
          isVisibility: true),
      const SizedBox(height: 32),
      BlocProvider.value(
        value: BlocProvider.of<AuthenticationCubit>(context),
        child: CustomButton.common(
            onTap: () {
              valid();
            },
            content: "Đăng ký"),
      ),
      const SizedBox(height: 8.0),
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back,
              size: 15, color: Color.fromRGBO(0, 51, 153, 1)),
          label: Text("Trở về trang đăng nhập",
              style: BaseTextStyle.fontFamilySemiBold(BaseColor.primary, 14)))
    ]);
  }

  void showSnackbarMsg(BuildContext context, String content,
      Color? backgroundColor, Color? textColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor ?? BaseColor.hint,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: BaseTextStyle.fontFamilyRegular(textColor ?? Colors.white, 14),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  void valid() async {
    final String name = _nameController.text;
    final String phone = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    if (validRegisterData()) {
      int validUserInput = await BlocProvider.of<AuthenticationCubit>(context)
          .registerValid(RegisterRequest(
              name: name,
              phone: phone,
              password: password,
              confirmPassword: confirmPassword));
      if (validUserInput == 200) {
        print("Register success");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RegisterPhonePage()));
        return;
      }
      if (validUserInput == 400) {
        _clearPassword();
        setState(() {
          _usernameError = "Email này đã tồn tại";
        });
        return;
      }
      _clearPassword();
      setState(() {
        showSnackbarMsg(
            context, "Đăng ký thất bại. Hãy thử lại", Colors.red, null);
      });
    }
  }

  bool validRegisterData() {
    final String name = _nameController.text;
    final String phone = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    if (AuthenticationLogic.checkName(name) != null) {
      setState(() {
        _nameError = AuthenticationLogic.checkName(name);
      });
      _clearPassword();
      return false;
    }
    if (AuthenticationLogic.checkPhoneNumber(phone) != null) {
      setState(() {
        _usernameError = AuthenticationLogic.checkPhoneNumber(phone);
      });
      _clearPassword();
      return false;
    }
    if (AuthenticationLogic.checkPassword(password) != null) {
      setState(() {
        _passwordError = AuthenticationLogic.checkPassword(password);
      });
      _clearPassword();
      return false;
    }
    if (AuthenticationLogic.checkPassword(confirmPassword) != null) {
      setState(() {
        _confirmPasswordError =
            AuthenticationLogic.checkPassword(confirmPassword);
      });
      _clearPassword();
      return false;
    }
    if (AuthenticationLogic.checkMatchPassword(password, confirmPassword) !=
        null) {
      setState(() {
        _passwordError =
            AuthenticationLogic.checkMatchPassword(password, confirmPassword);
        _confirmPasswordError =
            AuthenticationLogic.checkMatchPassword(password, confirmPassword);
      });
      _clearPassword();
      return false;
    }
    return true;
  }

  void _clearPassword() {
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _clearError() {
    setState(() {
      _nameError = null;
      _usernameError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });
  }
}
