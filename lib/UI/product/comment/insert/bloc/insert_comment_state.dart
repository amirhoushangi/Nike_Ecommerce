part of 'insert_comment_bloc.dart';

sealed class InsertCommentState extends Equatable {
  const InsertCommentState();

  @override
  List<Object> get props => [];
}

final class InsertCommentInitial extends InsertCommentState {
  @override
  List<Object> get props => [];
}

class InserCommentError extends InsertCommentState {
  final AppException exception;

  const InserCommentError(this.exception);
  @override
  List<Object> get props => [exception];
}

class InserCommentLoading extends InsertCommentState {}

class InserCommentSuccess extends InsertCommentState {
  final CommentEntitiy commentEntitiy;
  final String message;

  const InserCommentSuccess(this.commentEntitiy, this.message);
  @override
  List<Object> get props => [message, commentEntitiy];
}
