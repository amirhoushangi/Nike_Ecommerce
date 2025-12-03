import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/common/http_response_validator.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemotDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemotDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    String query = '';

    switch (sort) {
      case ProductSort.latest:
        query = '?_sort=id&_order=desc';
        break;
      case ProductSort.popular:
        query = '?_sort=discount&_order=desc';
        break;
      case ProductSort.priceHighToLow:
        query = '?_sort=price&_order=desc';
        break;
      case ProductSort.priceLowToHigh:
        query = '?_sort=price&_order=asc';
        break;
    }

    final response = await httpClient.get('/products$query');
    validateResponse(response);
    final product = <ProductEntity>[];
    (response.data as List).forEach((element) {
      product.add(ProductEntity.fromJson(element));
    });
    return product;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('/products');
    validateResponse(response);
    final product = <ProductEntity>[];
    (response.data as List).forEach((element) {
      product.add(ProductEntity.fromJson(element));
    });
    return product;
  }
}
