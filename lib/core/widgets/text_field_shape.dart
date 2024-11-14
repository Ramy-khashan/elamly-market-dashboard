import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_widget.dart';

class TextFormFieldShape extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final int? maxLine;
  final bool? isPassword;
  final bool  withPadding;
  final bool? hidePassword;
  final bool? isNumber;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTapPassword;

  final Function(dynamic text) validate;
  const TextFormFieldShape(
      {Key? key,
      this.title = "",
      required this.controller,
      this.isPassword = false,
      this.maxLine = 1,
      required this.validate,
      this.hint = "",
      this.onTapPassword,
      this.hidePassword,
      this.withPadding=false,
      this.inputFormatters,
      this.isNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextWidget(
                  text: title,
                  textSize: 18,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  isTitle: true,
                ),
              ),
        Padding(
          padding: withPadding ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
          child: TextFormField(
            controller: controller,
            validator: (val) => validate(val),
            maxLines: maxLine,
            obscureText: isPassword! ? hidePassword! : false,
            cursorColor: Colors.black,
            keyboardType: isNumber!
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              suffixIcon: isPassword!
                  ? IconButton(
                      onPressed: onTapPassword,
                      icon: Icon(hidePassword!
                          ? Icons.visibility
                          : Icons.visibility_off))
                  : null,
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
