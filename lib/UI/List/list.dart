import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/List/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/product/product.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('کفش های ورزشی'),
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) {
            bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(widget.sort));
            return bloc!;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                          )
                        ]),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 250,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 24, bottom: 24),
                                  child: Column(
                                    children: [
                                      Text(
                                        'انتخاب مرتب سازی',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: state.sortNames.length,
                                            itemBuilder: (context, index) {
                                              final selectedSortIndex =
                                                  state.sort;
                                              return InkWell(
                                                onTap: () {
                                                  bloc!.add(ProductListStarted(
                                                      index));
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 16, 8),
                                                  child: SizedBox(
                                                    height: 28,
                                                    child: Row(
                                                      children: [
                                                        Text(state
                                                            .sortNames[index]),
                                                        SizedBox(width: 8),
                                                        if (index ==
                                                            selectedSortIndex)
                                                          Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            size: 16,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.sort_down),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('مرتب سازی'),
                                      Text(
                                        ProductSort.names[state.sort],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1.5,
                            color: Colors.grey.shade100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.square_grid_2x2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: defaultScrollPhysics,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return ProductItem(
                            product: product, borderRadius: BorderRadius.zero);
                      },
                    ),
                  ),
                ],
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
