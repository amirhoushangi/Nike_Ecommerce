import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/comment.dart';
import 'package:nike_ecommerce_flutter/data/common/http_response_validator.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntitiy>> getAll({required int productId});
}

class CommentRemoteDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);

  @override
  Future<List<CommentEntitiy>> getAll({required int productId}) async {
    final response = await httpClient.get('/comments?id=$productId');
    validateResponse(response);
    final List<CommentEntitiy> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommentEntitiy.fromJson(element));
    });
    return comments;
  }
}
