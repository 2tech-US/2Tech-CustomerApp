import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:flutter/material.dart';

class OTPOption extends StatefulWidget {
  const OTPOption(
      {Key? key,
      required this.otpNum,
      this.height,
      this.width,
      this.decoration,
      this.textStyle})
      : super(key: key);
  final int otpNum;
  final double? height;

  final double? width;
  final InputDecoration? decoration;
  final TextStyle? textStyle;

  @override
  State<OTPOption> createState() => _OTPOptionState();
}

class _OTPOptionState extends State<OTPOption> {
  List<FocusNode> focus = [];
  List<int> values = [];
  int count = 0;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    for (int i = 0; i < widget.otpNum; i++) {
      focus.add(FocusNode());
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < widget.otpNum; i++) {
      focus[i].dispose();
      controllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          widget.otpNum, (index) => buildOtpComponent(index, size)),
    );
  }

  Widget buildOtpComponent(int position, Size size) {
    double optComponentSize =
        (size.width - 64 - widget.otpNum * 8 + 8) / widget.otpNum;
    return Container(
      alignment: Alignment.center,
      width: optComponentSize,
      child: CustomTextField.common(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        textEditingController: controllers[position],
        focusNode: focus[position],
        autoFocus: position == 0 ? true : false,
        textAlign: TextAlign.center,
        textStyle: BaseTextStyle.fontFamilyMedium(Colors.black, 24.0),
        textAlignVertical: TextAlignVertical.center,
        textInputType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1 && position < widget.otpNum) {
            FocusScope.of(context).requestFocus(focus[position + 1]);
          }
          if (value.isEmpty && position > 0) {
            FocusScope.of(context).requestFocus(focus[position - 1]);
          }
        },
        maxLength: 1,
      ),
    );
  }
}
