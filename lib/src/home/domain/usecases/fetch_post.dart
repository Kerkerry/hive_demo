import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/core/usecase/usecase.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:buub/src/home/domain/repositories/post_repository.dart';

class FetchPost extends UsecaseWithParams<Post, int> {
  final PostRepository _repository;

  FetchPost({required PostRepository repository}) : _repository = repository;

  @override
  ResultFuture<Post> call(int params) async =>
      _repository.fetchPost(id: params);
}
