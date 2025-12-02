import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const defultTextStyle = TextStyle(
        fontFamily: 'iranYekan', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
            bodyMedium: defultTextStyle,
            bodySmall: defultTextStyle.apply(
                color: LightThemeColors.secondryTextColor),
            titleLarge: defultTextStyle.copyWith(fontWeight: FontWeight.bold)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.secondaryColor,
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: LightThemeColors.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl,
          child: MyHomePage(title: 'فروشگاه نایک')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'دکمه پلاس را بفشارید',
            ),
            Text(
              'دکمه پلاس را بفشارید',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
