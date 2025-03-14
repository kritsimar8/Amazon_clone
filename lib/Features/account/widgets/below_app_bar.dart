import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
 
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
     final user = Provider.of<UserProvider>(context).user; 
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Row(
        children: [
          RichText(text: TextSpan(
            text: 'Hello, ',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'Simar',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                )
              )
            ]
          )),
        ],
      ),
    );
  }
}