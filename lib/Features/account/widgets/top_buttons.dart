import 'package:flutter/material.dart';
import 'package:test_flutter/Features/account/services/account_services.dart';
import 'package:test_flutter/Features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {

  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: (){}),
            AccountButton(text: 'Turn Seller', onTap: (){})
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: 'Log Out', onTap:()=> AccountService().logOut(context)),
            AccountButton(text: 'Your Wish List', onTap: (){})
          ],
        )
      ],
    );
  }
}