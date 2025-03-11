
import 'package:flutter/material.dart';
import 'package:test_flutter/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,
      style: TextStyle(
        color: color == null ? Colors.white : Colors.black
      ),
      ),
      
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        backgroundColor: color==null ? GlobalVariables.secondaryColor : color,
        minimumSize: const Size(double.infinity, 50)
      ),
    );
  }
}