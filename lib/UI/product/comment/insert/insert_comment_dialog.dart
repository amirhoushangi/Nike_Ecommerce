import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/UI/product/comment/insert/bloc/insert_comment_bloc.dart';
import 'package:nike_ecommerce_flutter/data/repo/comment_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';

class InsertCommentDialog extends StatefulWidget {
  final int productId;
  final ScaffoldMessengerState? scaffoldMessager;
  const InsertCommentDialog(
      {super.key, required this.productId, this.scaffoldMessager});

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  StreamSubscription? subscription;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = InsertCommentBloc(commentRepository, widget.productId);
        subscription = bloc.stream.listen((state) {
          if (state is InserCommentSuccess) {
            widget.scaffoldMessager
                ?.showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.of(context, rootNavigator: true).pop();
          } else if (state is InserCommentError) {
            widget.scaffoldMessager?.showSnackBar(
                SnackBar(content: Text(state.exception.message)));
            Navigator.of(context, rootNavigator: true).pop();
          }
        });
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 260,
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<InsertCommentBloc, InsertCommentState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    'ثبت نظر',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('عنوان')),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                        label: Text('متن نظر خود را اینجا وارد کنید')),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InsertCommentBloc>().add(
                          InserCommentFormSubmit(
                              _titleController.text, _contentController.text));
                    },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                        minimumSize:
                            WidgetStateProperty.all(const Size.fromHeight(56))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is InserCommentLoading)
                          CupertinoActivityIndicator(
                              color: Theme.of(context).colorScheme.onPrimary),
                        const Text('ذخیره'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
