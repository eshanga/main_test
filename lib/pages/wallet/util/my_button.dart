import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  final Color buttonTextColor; // Correct placement of the parameter

  const MyButton({
    Key? key,
    required this.iconImagePath,
    required this.buttonText,
    this.buttonTextColor = Colors.black, // Default color is black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                blurRadius: 19,
                spreadRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Image.asset(iconImagePath),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor, // Set the text color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
