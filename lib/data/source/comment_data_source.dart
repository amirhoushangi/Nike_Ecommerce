import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/comment.dart';
import 'package:nike_ecommerce_flutter/data/common/http_response_validator.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntitiy>> getAll({required int productId});
  Future<CommentEntitiy> inser(String title, String content, int productId);
}

class CommentRemoteDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);

  @override
  Future<List<CommentEntitiy>> getAll({required int productId}) async {
    final response =
        await httpClient.get('/api/comments?product_id=$productId');
    validateResponse(response);
    final List<CommentEntitiy> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommentEntitiy.fromJson(element));
    });
    return comments;
  }

  @override
  Future<CommentEntitiy> inser(
      String title, String content, int productId) async {
    final response = await httpClient.post('/comment/add',
        data: {'title': title, 'content': content, 'product_id': productId});
    validateResponse(response);
    return CommentEntitiy.fromJson(response.data);
  }
}
