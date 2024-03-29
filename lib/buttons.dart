import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTap;

  const MyButton(
      {this.color, this.textColor, required this.buttonText, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            color: color,
            child: Center(
              child: Text(buttonText,
                  style: TextStyle(color: textColor, fontSize: 25)),
            ),
          ),
        ),
      ),
    );
  }
}
