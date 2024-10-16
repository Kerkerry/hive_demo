import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/core/usecase/usecase.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:buub/src/home/domain/repositories/post_repository.dart';

class FetchAllPosts extends UsecaseWithoutParams<List<Post>> {
  final PostRepository _repository;

  FetchAllPosts({required PostRepository repository})
      : _repository = repository;
  @override
  ResultFuture<List<Post>> call() async => _repository.fetchAllPosts();
}
