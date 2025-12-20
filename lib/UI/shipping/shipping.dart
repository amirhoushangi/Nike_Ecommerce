import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/UI/cart/price_info.dart';
import 'package:nike_ecommerce_flutter/UI/receipt/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class ShippingScreen extends StatelessWidget {
  final int payablePrice;
  final int shippinCost;
  final int totalPrice;

  const ShippingScreen(
      {super.key,
      required this.payablePrice,
      required this.shippinCost,
      required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                  label: Text('نام'),
                  labelStyle:
                      TextStyle(color: LightThemeColors.secondryTextColor),
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                  label: Text('نام خانوادگی'),
                  labelStyle:
                      TextStyle(color: LightThemeColors.secondryTextColor),
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                  label: Text('شماره تماس'),
                  labelStyle:
                      TextStyle(color: LightThemeColors.secondryTextColor),
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                  label: Text('کد پستی'),
                  labelStyle:
                      TextStyle(color: LightThemeColors.secondryTextColor),
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                  label: Text('آدرس'),
                  labelStyle:
                      TextStyle(color: LightThemeColors.secondryTextColor),
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 12),
            PriceInfo(
                payblePrice: payablePrice,
                shippinCost: shippinCost,
                totalPrice: totalPrice),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentReceiptScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: LightThemeColors.primaryColor,
                        ),
                        foregroundColor: LightThemeColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    child: const Text("پرداخت در محل")),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: LightThemeColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: const Text("پرداخت اینترنتی"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
