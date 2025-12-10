part of 'comment_list_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListLoading extends CommentListState {}

class CommentListSuccess extends CommentListState {
  final List<CommentEntitiy> comments;

  const CommentListSuccess(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentListError extends CommentListState {
  final AppException exception;

  const CommentListError(this.exception);
  @override
  List<Object> get props => [exception];
}
