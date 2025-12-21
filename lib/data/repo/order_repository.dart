import 'package:nike_ecommerce_flutter/common/http_Client.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;

  OrderRepository(this.orderDataSource);

  @override
  Future<SubmitOrderResult> create(SubmitOrderParams params) =>
      orderDataSource.create(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) =>
      orderDataSource.getPaymentReceipt(orderId);
}
