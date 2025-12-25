import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/product/bloc/product_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/product/comment/comment_list.dart';
import 'package:nike_ecommerce_flutter/UI/product/comment/insert/insert_comment_dialog.dart';
import 'package:nike_ecommerce_flutter/UI/widgets/image.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/data/products.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  StreamSubscription<ProductState>? stateSubscription = null;

  final GlobalKey<ScaffoldMessengerState> _scaffoldkey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldkey.currentState?.showSnackBar(const SnackBar(
                content: Text('با موفقیت به سبد خرید شما اضافه شد'),
              ));
            } else if (state is ProductAddToCartError) {
              _scaffoldkey.currentState?.showSnackBar(SnackBar(
                content: Text(state.exception.message),
              ));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldkey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) => FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(CartAddButtonClick(widget.product.id));
                  },
                  label: state is productAddToCartButtonLoading
                      ? const CupertinoActivityIndicator()
                      : const Text('افزودن به سبد خرید'),
                ),
              ),
            ),
            body: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace:
                      ImageLoadingService(imageUrl: widget.product.imageUrl),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLable,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                Text(widget.product.price.withPriceLable),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'این کتونی شدیدا برای دویدن و راه رفتن مناسب است و تقریبا هیچ فشار مخربی را نمیذارد به پا و زانوان شما انتقال داده شود',
                          style: TextStyle(height: 1.4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      builder: (context) {
                                        return InsertCommentDialog(
                                          productId: widget.product.id,
                                          scaffoldMessager:
                                              _scaffoldkey.currentState,
                                        );
                                      });
                                },
                                child: const Text('ثبت نظر')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
