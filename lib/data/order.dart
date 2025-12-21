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
