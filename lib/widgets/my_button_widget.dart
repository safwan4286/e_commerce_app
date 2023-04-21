import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  MyButtonWidget(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      this.isButtonClicked = false});
  final String text;
  final Color textColor;
  final Color buttonColor;
  bool isButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(10)),
      child: isButtonClicked
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: textColor, fontWeight: FontWeight.bold),
            ),
    );
  }
}
