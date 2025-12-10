import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/UI/product/details.dart';
import 'package:nike_ecommerce_flutter/UI/widgets/image.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.borderRadius,
  });

  final ProductEntity product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
          ),
          child: SizedBox(
            width: 176,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 176,
                      height: 189,
                      child: ImageLoadingService(
                          imageUrl: product.imageUrl,
                          borderRadius: borderRadius),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: const Icon(
                          CupertinoIcons.heart,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Text(
                    product.previousPrice.withPriceLable,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
                  child: Text(product.price.withPriceLable),
                ),
              ],
            ),
          ),
        ));
  }
}
