import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class PriceInfo extends StatelessWidget {
  final int payblePrice;
  final int shippinCost;
  final int totalPrice;

  const PriceInfo(
      {super.key,
      required this.payblePrice,
      required this.shippinCost,
      required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, right: 8),
          child: Text(
            'جزئیات خرید',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                        text: TextSpan(
                            text: totalPrice.separateByComma,
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(color: LightThemeColors.secondaryColor),
                            children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                fontSize: 10,
                              ))
                        ])),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(shippinCost.withPriceLable),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                        text: TextSpan(
                            text: payblePrice.separateByComma,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.normal))
                        ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
