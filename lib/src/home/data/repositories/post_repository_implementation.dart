import 'package:buub/core/errors/api_exception.dart';
import 'package:buub/core/errors/api_failure.dart';
import 'package:buub/core/errors/log_helper.dart';
import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/src/home/data/datasource/datasource.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:buub/src/home/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImplementation implements PostRepository {
  final Datasource _datasource;

  PostRepositoryImplementation({required Datasource datasource})
      : _datasource = datasource;

  @override
  ResultFuture<List<Post>> fetchAllPosts() async {
    try {
      final result = await _datasource.fetchPosts();
      return Right(result);
    } on APIException catch (e) {
      logger.d(e);
      return Left(APIFailure.fromException(e: e));
    }
  }

  @override
  ResultFuture<Post> fetchPost({required int id}) async {
    try {
      final result = await _datasource.getPost(id: id);
      return Right(result);
    } on APIException catch (e) {
      logger.d(e);
      return Left(APIFailure.fromException(e: e));
    }
  }
}
