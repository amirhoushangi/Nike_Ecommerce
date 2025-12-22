import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        actions: [
          IconButton(
              onPressed: () {
                authRepository.signOut();
                CartRepository.cartItemCountNotifier.value = 0;
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 65,
              height: 65,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 32, bottom: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Image.asset('assets/img/nike_logo.png'),
            ),
            const Text('amirhoushangi1382@gmail.com'),
            const SizedBox(height: 32),
            const Divider(
              height: 1,
              color: LightThemeColors.secondryTextColor,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                height: 56,
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.heart),
                    SizedBox(width: 16),
                    Text('لیست علاقه مندی ها'),
                  ],
                ),
              ),
            ),
            const Divider(
              color: LightThemeColors.secondryTextColor,
              height: 1,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                height: 56,
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.cart),
                    SizedBox(width: 16),
                    Text('سوابق سفارش'),
                  ],
                ),
              ),
            ),
            const Divider(
              color: LightThemeColors.secondryTextColor,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
