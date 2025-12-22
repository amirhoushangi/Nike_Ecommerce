import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:nike_ecommerce_flutter/UI/receipt/payment_receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final String bankGatewayUrl;
  const PaymentGatewayScreen({super.key, required this.bankGatewayUrl});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('page started;$url');
            final uri = Uri.parse(url);
            if (uri.pathSegments.contains('checkout') &&
                uri.host == 'experdevelopers.ir') {
              final orderId = int.parse(uri.queryParameters['order_id']!);
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PaymentReceiptScreen(orderId: orderId)));
            }
          },
          onPageFinished: (url) {
            debugPrint('page finished;$url');
          },
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bankGatewayUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('درگاه پرداخت')),
      body: WebViewWidget(controller: controller),
    );
  }
}
