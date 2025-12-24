import 'package:nike_ecommerce_flutter/data/products.dart';

class SubmitOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  SubmitOrderResult(this.orderId, this.bankGatewayUrl);
  SubmitOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class SubmitOrderParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  SubmitOrderParams(this.firstName, this.lastName, this.phoneNumber,
      this.postalCode, this.address, this.paymentMethod);
}

enum PaymentMethod { online, cashOneDelivery }

class OrderEntity {
  final int id;
  final int payablePrice;
  final List<ProductEntity> items;

  OrderEntity(this.id, this.payablePrice, this.items);
  OrderEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payablePrice = json['payable'],
        items = (json['order_items'] as List)
            .map((item) => ProductEntity.fromJson(item['product']))
            .toList();
}
