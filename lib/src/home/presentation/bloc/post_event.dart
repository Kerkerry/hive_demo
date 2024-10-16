part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostEvent {
  const GetPostsEvent();
}

class GetPostEvent extends PostEvent {
  final int id;
  const GetPostEvent({required this.id});
}
