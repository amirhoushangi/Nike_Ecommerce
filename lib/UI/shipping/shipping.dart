import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/cart/price_info.dart';
import 'package:nike_ecommerce_flutter/UI/payment_webview.dart';
import 'package:nike_ecommerce_flutter/UI/receipt/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/UI/shipping/bloc/shipping_bloc.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/order_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippinCost;
  final int totalPrice;

  ShippingScreen(
      {super.key,
      required this.payablePrice,
      required this.shippinCost,
      required this.totalPrice});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'امیر');

  final TextEditingController lastNameController =
      TextEditingController(text: 'هوشنگی');

  final TextEditingController phoneNumberController =
      TextEditingController(text: '09366181175');

  final TextEditingController postalCodeController =
      TextEditingController(text: '123456789');

  final TextEditingController addressController =
      TextEditingController(text: 'خیابان شهید بهشتی');

  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(event.appException.message)));
            } else if (event is ShippingSuccess) {
              if (event.data.bankGatewayUrl.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(
                              bankGatewayUrl: event.data.bankGatewayUrl,
                            )));
              } else {
                CartRepository.cartItemCountNotifier.value = 0;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentReceiptScreen(
                          orderId: event.data.orderId,
                        )));
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                    label: Text('نام'),
                    labelStyle:
                        TextStyle(color: LightThemeColors.secondryTextColor),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    label: Text('نام خانوادگی'),
                    labelStyle:
                        TextStyle(color: LightThemeColors.secondryTextColor),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                    label: Text('شماره تماس'),
                    labelStyle:
                        TextStyle(color: LightThemeColors.secondryTextColor),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                    label: Text('کد پستی'),
                    labelStyle:
                        TextStyle(color: LightThemeColors.secondryTextColor),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                    label: Text('آدرس'),
                    labelStyle:
                        TextStyle(color: LightThemeColors.secondryTextColor),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 12),
              PriceInfo(
                  payblePrice: widget.payablePrice,
                  shippinCost: widget.shippinCost,
                  totalPrice: widget.totalPrice),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                      ShippingCreateOrder(SubmitOrderParams(
                                          firstNameController.text,
                                          lastNameController.text,
                                          phoneNumberController.text,
                                          postalCodeController.text,
                                          addressController.text,
                                          PaymentMethod.cashOneDelivery)));
                                },
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: LightThemeColors.primaryColor,
                                    ),
                                    foregroundColor:
                                        LightThemeColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4))),
                                child: const Text("پرداخت در محل")),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                    ShippingCreateOrder(SubmitOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        postalCodeController.text,
                                        addressController.text,
                                        PaymentMethod.online)));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      LightThemeColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              child: const Text("پرداخت اینترنتی"),
                            ),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
