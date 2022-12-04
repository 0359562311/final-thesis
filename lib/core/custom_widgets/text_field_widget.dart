import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {Key? key,
      required this.controller,
      this.textInputAction = TextInputAction.next,
      this.isEnable = true,
      this.buildCounter,
      this.maxLength,
      this.autoFocus = true,
      this.border,
      this.borderSize,
      this.fillColor,
      this.onChanged,
      this.padding,
      this.isPassword = false,
      this.icon,
      this.errorText,
      this.labelText,
      this.titleText,
      this.hintText,
      this.inputFormatters,
      this.minLines,
      this.maxLines,
      this.height,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.readOnly = false,
      this.onTap,
      this.suffixIcon,
      this.onTapRightIcon,
      this.onSubmitted,
      this.disableTap = false,
      this.customInputStyle,
      this.labelStyle,
      this.underLineColor,
      this.errorTextStyle,
      this.validator,
      this.enabledBorderColor})
      : super(key: key);

//  final GlobalKey key;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool isEnable;
  final bool autoFocus;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String>? onChanged;
  final bool isPassword;
  final String? errorText;
  final String? labelText;
  final String? titleText;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final double? border;
  final Color? fillColor;
  final BorderSide? borderSize;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSubmitted;
  final dynamic icon;
  final double? height;
  final bool readOnly;
  final bool disableTap;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Function? onTapRightIcon;
  final TextStyle? customInputStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorTextStyle;
  final InputCounterWidgetBuilder? buildCounter;
  final int? maxLength;
  final Color? underLineColor;
  final Color? enabledBorderColor;

  @override
  State<StatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isPassword == true) {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      enabled: widget.isEnable,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      buildCounter: widget.buildCounter,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      cursorColor: AppColor.black,
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          fillColor: widget.isEnable
              ? (widget.fillColor ?? AppColor.white)
              : (widget.fillColor ?? AppColor.background),
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderSide: widget.borderSize ??
                BorderSide(
                    color: widget.underLineColor ?? AppColor.background,
                    width: 1.0),
            // borderRadius: BorderRadius.circular(widget.border ?? 10.h),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: widget.borderSize ??
                BorderSide(
                    color: widget.enabledBorderColor ?? AppColor.background,
                    width: 1.0),
            // borderRadius: BorderRadius.circular(widget.border ?? 10.h),
          ),
          border: OutlineInputBorder(
            borderSide: widget.borderSize ??
                BorderSide(color: AppColor.background, width: 1.0),
            borderRadius: BorderRadius.circular(widget.border ?? 10),
          ),
          errorText: widget.errorText,
          errorMaxLines: 1000,
          errorBorder: OutlineInputBorder(
            borderSide: widget.borderSize ??
                BorderSide(color: AppColor.background, width: 1.0),
            // borderRadius: BorderRadius.circular(widget.border ?? 10.h),
          ),
          // prefixText: widget.isRequired ? "*" : "",
          prefixStyle: TextStyle(
            color: AppColor.background,
          ),
          counterStyle:
              Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 10),
          prefixIcon: widget.icon == null
              ? null
              : (widget.icon is Widget
                  ? widget.icon
                  : (widget.icon is String
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(widget.icon,
                              fit: BoxFit.fitHeight,
                              height: 5,
                              color: AppColor.background),
                        )
                      : Icon(
                          widget.icon,
                          size: 20,
                          color: AppColor.background,
                        ))),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () => widget.onTapRightIcon == null
                      ? null
                      : widget.onTapRightIcon!(),
                  child: widget.suffixIcon,
                )
              : widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        semanticLabel:
                            _obscureText ? 'show password' : 'hide password',
                        color: AppColor.background,
                      ),
                    )
                  : null,
          labelStyle: widget.labelStyle ??
              TextStyle(
                  color: AppColor.background,
                  fontSize: 12,
                  fontWeight: FontWeight
                      .w500) /*.copyWith(color: widget.isEnable ? R.color.black : R.color.borderColor)*/,
          hintStyle:
              TextStyle(fontSize: 14, height: 27 / 14, color: Colors.grey),
          errorStyle: widget.errorTextStyle ??
              Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: AppColor.background)),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      minLines: widget.minLines,
      maxLines: widget.isPassword == true ? 1 : widget.maxLines,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: widget.customInputStyle ??
          Theme.of(context).textTheme.bodyText1?.copyWith(
                color: widget.isEnable ? AppColor.black : AppColor.background,
              ),
    );
  }
}
