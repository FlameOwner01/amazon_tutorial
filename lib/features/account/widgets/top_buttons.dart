import 'package:amazaon_tutorial/features/account/services/account_services.dart';
import 'package:amazaon_tutorial/features/account/widgets/account.button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your orders",
              onTap: () {},
            ),
            AccountButton(text: "Turn Seller", onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Logout",
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(text: "Your Wish List", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
