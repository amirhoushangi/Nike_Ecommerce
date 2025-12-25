import 'package:nike_ecommerce_flutter/common/http_Client.dart';
import 'package:nike_ecommerce_flutter/data/comment.dart';
import 'package:nike_ecommerce_flutter/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntitiy>> getAll({required int productId});
  Future<CommentEntitiy> inser(String title, String content, int productId);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntitiy>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);

  @override
  Future<CommentEntitiy> inser(String title, String content, int productId) {
    return dataSource.inser(title, content, productId);
  }
}
