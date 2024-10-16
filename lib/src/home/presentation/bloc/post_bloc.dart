import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:buub/src/home/domain/usecases/fetch_all_posts.dart';
import 'package:buub/src/home/domain/usecases/fetch_post.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchAllPosts _fetchAllPosts;
  final FetchPost _fetchPost;
  PostBloc({required FetchAllPosts posts, required FetchPost post})
      : _fetchAllPosts = posts,
        _fetchPost = post,
        super(PostInitial()) {
    on<GetPostsEvent>(_fetchAllPostsHandler);
    on<GetPostEvent>(_fetchPostHandler);
  }

  FutureOr<void> _fetchAllPostsHandler(
      GetPostsEvent event, Emitter<PostState> emit) async {
    emit(const LoadingPostState());
    final result = await _fetchAllPosts();
    result.fold((failure) => emit(PostErrorState(message: failure.message)),
        (posts) => emit(PostsLoadedState(posts: posts)));
  }

  FutureOr<void> _fetchPostHandler(
      GetPostEvent event, Emitter<PostState> emit) async {
    emit(const LoadingPostState());
    final result = await _fetchPost(event.id);
    result.fold((failure) => emit(PostErrorState(message: failure.message)),
        (post) => emit(PostLoadedState(post: post)));
  }
}
