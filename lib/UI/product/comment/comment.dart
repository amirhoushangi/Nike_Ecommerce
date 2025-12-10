import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/comment.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class CommentItem extends StatelessWidget {
  final CommentEntitiy comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: LightThemeColors.secondryTextColor, width: 1),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title),
                  const SizedBox(height: 4),
                  Text(
                    comment.email,
                    style: themeData.textTheme.titleSmall,
                  ),
                ],
              ),
              Text(
                comment.date,
                style: themeData.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            comment.content,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
