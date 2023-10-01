import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/router.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_calculator.dart';
import '../../components/custom_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Monthly Subscription',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '\$5 per month',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
                width: sizer(true, 213, context),
                height: 51,
                singleBigButton: true,
                isTextBig: false,
                color: AppColors.primary,
                content: 'Subscribe Now ',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteHelper.loginRoute);
                }),
            SizedBox(height: 20),
            Text(
              'Benefits:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('- Ad-free experience'),
            Text('- Access to premium content'),
            Text('- Priority support'),
          ],
        ),
      ),
    );
  }
}
