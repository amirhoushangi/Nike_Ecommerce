import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    const Size.fromHeight(56),
                  ),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )))),
          colorScheme: themeData.colorScheme.copyWith(outline: onBackground),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: onBackground),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: LightThemeColors.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white)))),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.primary,
        body: Padding(
          padding: const EdgeInsets.only(right: 48, left: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: Colors.white,
                width: 120,
              ),
              const SizedBox(height: 16),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: const TextStyle(color: onBackground, fontSize: 22),
              ),
              const SizedBox(height: 24),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: const TextStyle(
                  color: onBackground,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text('آدرس ایمیل'),
                ),
              ),
              const SizedBox(height: 16),
              const _PasswordTextField(onBackground: onBackground),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  //await authRepository.login("amirh82@gmail.com", "13822831");
                  authRepository.refreshToken();
                },
                child: Text(isLogin ? 'ورود' : 'ثبت نام'),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                      style: TextStyle(color: onBackground.withOpacity(0.7)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: const TextStyle(
                          color: LightThemeColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: LightThemeColors.primaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
  });

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: widget.onBackground.withOpacity(0.6),
          ),
        ),
        label: const Text('رمز عبور'),
      ),
    );
  }
}
