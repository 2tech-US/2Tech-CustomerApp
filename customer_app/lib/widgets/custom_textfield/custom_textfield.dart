import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';

class CustomTextField {
  static Widget common(
      {required ValueChanged<String> onChanged,
      String? labelText,
      String? hintText,
      String? errorText,
      bool required = false,
      bool isVisibility = false,
      EdgeInsets? contentPadding,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      bool autoFocus = false,
      bool? isPrefix = false,
      int? maxLength,
      TextStyle? textStyle,
      TextAlign textAlign = TextAlign.start,
      TextAlignVertical textAlignVertical = TextAlignVertical.center,
      TextInputAction? textInputAction,
      TextInputType? textInputType}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((labelText != null))
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(labelText,
                      style:
                          BaseTextStyle.fontFamilySemiBold(Colors.black, 14)),
                  if (required == true)
                    Text(" *",
                        style: BaseTextStyle.fontFamilySemiBold(
                            BaseColor.error, 14))
                ])),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: BaseColor.primary.withOpacity(0.15),
                        spreadRadius: -2,
                        blurRadius: 8 // changes position of shadow
                        )
                  ]),
              child: TextFormField(
                  onChanged: onChanged,
                  obscureText: isVisibility,
                  obscuringCharacter: "*",
                  style: textStyle ??
                      BaseTextStyle.fontFamilyRegular(Colors.black, 14.0),
                  focusNode: focusNode,
                  controller: textEditingController,
                  autofocus: autoFocus,
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  textInputAction: textInputAction,
                  maxLength: maxLength,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                      prefixIcon: isPrefix! ? Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon_vietnam_flag.png',
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(width: 5.0),
                            Text('+84', style: BaseTextStyle.fontFamilyRegular(Colors.black54, 14),)
                          ],
                        ),
                      ) : null,
                      prefixIconConstraints: const BoxConstraints(
                          minWidth: 25, minHeight: 20, maxWidth: 80, maxHeight: 30),
                      hintText: hintText,
                      counter: const Offstage(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: contentPadding ??
                          const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                      hintStyle:
                          BaseTextStyle.fontFamilyRegular(BaseColor.hint, 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: errorText != null
                                ? BaseColor.error
                                : Colors.transparent,
                            width: 0.0,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                              color: errorText != null
                                  ? BaseColor.error
                                  : BaseColor.primary,
                              width: 1.0)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                              color: BaseColor.error, width: 1.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                              color: BaseColor.error, width: 1.0))))),
          if (errorText != null)
            Text(errorText,
                style: BaseTextStyle.fontFamilyRegular(BaseColor.error, 12))
        ]);
  }
}
