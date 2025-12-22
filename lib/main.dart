import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/UI/auth/auth.dart';
import 'package:nike_ecommerce_flutter/UI/root.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
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
        dividerColor: LightThemeColors.secondryTextColor,
        hintColor: LightThemeColors.secondryTextColor,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        LightThemeColors.primaryTextColor.withOpacity(0.1)))),
        textTheme: TextTheme(
            titleSmall: defultTextStyle.apply(
                color: LightThemeColors.secondryTextColor),
            bodyMedium: defultTextStyle,
            bodySmall: defultTextStyle.apply(
                color: LightThemeColors.secondryTextColor),
            titleLarge: defultTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: LightThemeColors.primaryTextColor,
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
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
