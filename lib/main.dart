import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/UI/auth/auth.dart';
import 'package:nike_ecommerce_flutter/UI/root.dart';
import 'package:nike_ecommerce_flutter/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    productRepository.getAll(3).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    const defultTextStyle = TextStyle(
        fontFamily: 'iranYekan', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
            titleSmall: defultTextStyle.apply(
                color: LightThemeColors.secondryTextColor),
            bodyMedium: defultTextStyle,
            bodySmall: defultTextStyle.apply(
                color: LightThemeColors.secondryTextColor),
            titleLarge: defultTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.secondaryColor,
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: LightThemeColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.all(LightThemeColors.primaryColor),
            textStyle: WidgetStateProperty.all(
              defultTextStyle.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: AuthScreen()),
    );
  }
}
