import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_payment/buttons/pay_buttons.dart';

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
  final pay = HNGPay();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          "Subscription",
          style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.bold),
        ),),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          "Monthly Subscription",
          style: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.bold),
        ),
            SizedBox(height: 20),
            Text(
              "\$5 per month",
              style: GoogleFonts.nunito(color: Colors.green,fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            Container(
              child: Platform.isIOS
                  ? pay.applePay(amountToPay: '5')
                  : Platform.isAndroid
                  ? pay.googlePay(amountToPay: '5')
                  : null, // You may want to handle unsupported platforms differently
            ),

            // CustomButton(
            //     width: sizer(true, 213, context),
            //     height: 51,
            //     singleBigButton: true,
            //     isTextBig: false,
            //     color: AppColors.primary,
            //     content: 'Subscribe Now ',
            //     onTap: () {
            //       Navigator.of(context).pushNamed(RouteHelper.loginRoute);
            //     }),
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
