import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(
                  color: LightThemeColors.secondryTextColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  'پرداخت با موفقیت انجام شد',
                  style: themeData.textTheme.titleLarge!
                      .apply(color: LightThemeColors.primaryColor),
                ),
                const SizedBox(height: 32),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وضعیت سفارش',
                      style:
                          TextStyle(color: LightThemeColors.secondryTextColor),
                    ),
                    Text(
                      'پرداخت شده',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const Divider(
                  color: LightThemeColors.secondryTextColor,
                  height: 32,
                  thickness: 1,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مبلغ',
                      style:
                          TextStyle(color: LightThemeColors.secondryTextColor),
                    ),
                    Text(
                      '149000 تومان',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: LightThemeColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text('بازگشت به صفحه اصلی')),
        ],
      ),
    );
  }
}
