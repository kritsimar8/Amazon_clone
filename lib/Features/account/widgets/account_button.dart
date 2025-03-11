import 'package:flutter/material.dart';
import 'package:test_flutter/constants/global_variables.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(0, 0, 0, 0), ),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
           
            
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal
            ),
          )),
      ),
    );
  }
}