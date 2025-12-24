import 'package:nike_ecommerce_flutter/common/http_Client.dart';
import 'package:nike_ecommerce_flutter/data/products.dart';
import 'package:nike_ecommerce_flutter/data/source/product_data_source.dart';

final productRepository = ProductRepository(
  ProductRemotDataSource(httpClient),
);

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
