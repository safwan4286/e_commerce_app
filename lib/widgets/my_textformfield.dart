import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFieldWidget extends StatelessWidget {
  MyTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.lebelText,
      required this.keybordType,
      required this.textInputAction,
      required this.icon,
      this.obscureText = false,
      this.maxlength,
      required this.functoin,
      this.focusnode,
      this.sufixIcon,
      this.onSubmit,
      this.textInputFormatter});

  final TextEditingController controller;
  final String lebelText;
  final TextInputType keybordType;
  final TextInputAction textInputAction;
  bool obscureText;
  final IconData icon;
  final String? Function(String?)? functoin;
  int? maxlength;
  IconButton? sufixIcon;
  FocusNode? focusnode;
  List<TextInputFormatter>? textInputFormatter;
  Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.only(left: 20),
            child: TextFormField(
              keyboardType: keybordType,
              textInputAction: textInputAction,
              obscuringCharacter: '*',
              obscureText: obscureText,
              decoration: InputDecoration(
                suffixIcon: sufixIcon,
                labelText: lebelText,
              ),
              controller: controller,
              validator: functoin,
              maxLength: maxlength,
              inputFormatters: textInputFormatter,
              focusNode: focusnode,
              onFieldSubmitted: onSubmit,

              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ),
        ]);
  }
}
