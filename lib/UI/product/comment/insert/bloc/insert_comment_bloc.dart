import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_flutter/common/exeptions.dart';
import 'package:nike_ecommerce_flutter/data/comment.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/comment_repository.dart';

part 'insert_comment_event.dart';
part 'insert_comment_state.dart';

class InsertCommentBloc extends Bloc<InsertCommentEvent, InsertCommentState> {
  final int productId;

  final ICommentRepository commentRepository;
  InsertCommentBloc(this.commentRepository, this.productId)
      : super(InsertCommentInitial()) {
    on<InsertCommentEvent>((event, emit) async {
      if (event is InserCommentFormSubmit) {
        if (!AuthRepository.isUserLoggedIn()) {
          emit(InserCommentError(
              AppException(message: 'لطفا وارد حساب کاربری خود شوید')));
        } else {
          if (event.title.isNotEmpty && event.content.isNotEmpty) {
            try {
              emit(InserCommentLoading());
              final comment = await commentRepository.inser(
                  event.title, event.content, productId);
              emit(InserCommentSuccess(comment,
                  'نظر شما با موفقیت ثبت شد و پس از تایید منتشر خواهد شد'));
            } catch (e) {
              emit(InserCommentError(AppException()));
            }
          } else {
            emit(InserCommentError(
                AppException(message: 'عنوان و متن نظر خود را وارد کنید')));
          }
        }
      }
    });
  }
}
