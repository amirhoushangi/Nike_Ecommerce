import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/List/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/product/product.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';

class ProductListScreen extends StatelessWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('کفش های ورزشی'),
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) =>
              ProductListBloc(productRepository)..add(ProductListStarted(sort)),
          child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return GridView.builder(
                physics: defaultScrollPhysics,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65,
                  crossAxisCount: 2,
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return ProductItem(
                      product: product, borderRadius: BorderRadius.zero);
                },
              );
            } else if (state is ProductListLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is ProductListError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else {
              throw Exception('state is not valid');
            }
          }),
        ));
  }
}
