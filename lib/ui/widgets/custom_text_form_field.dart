import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String Function(String) validator;
  final Function(String) onSaved;
  final bool isPassword;
  final bool isEmail;
  final Widget suffixIcon;
  final Color filledColor;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final int maxLines;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final Icon icon;
  final Widget prefixIcon;
  final bool readOnly;
  final double height;
  final TextDirection textDirection;
  final String initialValue;

  const CustomTextFormField(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.suffixIcon,
      this.filledColor,
      this.textInputType,
      this.onChanged,
      this.onFieldSubmitted,
      this.maxLines,
      this.icon,
      this.prefixIcon,
      this.labelStyle,
      this.hintStyle,
      this.textEditingController,
      this.readOnly,
      this.height,
      this.textDirection,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outLineBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(width: 0.2, color: Colors.black),
    );
    // ignore: sized_box_for_whitespace
    return Container(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextFormField(
          initialValue: initialValue,
          textDirection: textDirection,
          //expands: true,
          readOnly: readOnly ?? false,
          controller: textEditingController,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.black, fontSize: 22),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            icon: icon,
            prefixIcon: prefixIcon,
            isDense: true,
            disabledBorder: outLineBorder,
            focusedErrorBorder: outLineBorder,
            errorBorder: outLineBorder,
            enabledBorder: outLineBorder,
            focusedBorder: outLineBorder,
            suffixIcon: suffixIcon,
            hintText: hintText,
            //contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: filledColor ?? Theme.of(context).scaffoldBackgroundColor,
          ),
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: isPassword ? true : false,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          onSaved: onSaved,
          keyboardType: textInputType,
        ),
      ),
    );
  }
}
