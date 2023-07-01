import 'package:animated_login/animated_login.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../Config/AppConstant.dart';

//CustomTextInputField
class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    this.required = false,
    this.phoneType = false,
    required this.focusNode,
    required this.controller,
    this.finish = false,
    required this.nextFocus,
    this.fillColor,
    this.numberType = false,
    this.valCallback,
    this.validator,
  }) : super(key: key);
  final IconData icon;
  final String hint;
  final bool required;
  final bool phoneType;
  final bool numberType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool finish; //When finish value is false required nextFocus
  final FocusNode nextFocus;
  final Color? fillColor;
  final Function(String)? valCallback;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (v) {
        finish
            ? FocusScope.of(context).requestFocus()
            : FocusScope.of(context).requestFocus(nextFocus);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: valCallback,
      textInputAction: finish ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon),
        hintText: required ? "$hint (Required)" : "$hint",
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        isDense: true,
        fillColor: fillColor,
      ),
      keyboardType: phoneType
          ? TextInputType.phone
          : numberType
              ? TextInputType.number
              : TextInputType.text,
      style: TextStyle(color: kFontColorPallets[1], fontSize: 14),
    );
  }
}

//CustomPasswordInputField
class CustomPasswordTextInputField extends StatefulWidget {
  const CustomPasswordTextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    this.required = false,
    required this.controller,
    this.finish = false,
    required this.nextFocusNode,
    required this.focusNode,
    this.onSubmit,
    this.fillColor,
    this.valCallback,
    this.validator,
  }) : super(key: key);
  final IconData icon;
  final String hint;
  final bool required;
  final TextEditingController controller;
  final bool finish;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Function(String)? onSubmit;
  final Color? fillColor;
  final Function(String)? valCallback;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordTextInputField> createState() =>
      _CustomPasswordTextInputFieldState();
}

class _CustomPasswordTextInputFieldState
    extends State<CustomPasswordTextInputField> {
  @override
  late bool showPassword;
  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.send,
      controller: widget.controller,
      obscureText: !showPassword,
      onChanged: widget.valCallback,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: IconButton(
            icon: showPassword
                ? Icon(EvaIcons.eyeOutline)
                : Icon(EvaIcons.eyeOff2Outline),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            }),
        hintText:
            widget.required ? "${widget.hint} (Required)" : "${widget.hint}",
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        isDense: true,
        fillColor: widget.fillColor,
      ),
      style: TextStyle(color: kFontColorPallets[1], fontSize: 14),
      focusNode: widget.focusNode,
      //onSubmitted: widget.onSubmit,
    );
  }
}
