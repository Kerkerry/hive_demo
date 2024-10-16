import 'package:buub/src/home/presentation/bloc/post_bloc.dart';
import 'package:buub/src/home/presentation/widgets/loading_column_widget.dart';
import 'package:buub/src/home/presentation/widgets/single_post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getPosts() async {
    context.read<PostBloc>().add(const GetPostsEvent());
  }
  

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Catching post"),
            centerTitle: true,
          ),
          body: state is LoadingPostsState
              ? const LoadingColumnWidget(message: "Fetching posts")
              : state is PostsLoadedState
                  ? ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return SinglePostCardWidget(post: post);
                      },
                    )
                  : state is PostErrorState
                      ? Center(
                          child: Text(
                          "Error: ${state.message}",
                        ))
                      : const SizedBox.shrink(),
          floatingActionButton: IconButton(
              onPressed: () =>
                  context.read<PostBloc>().add(const GetPostsEvent()),
              icon: const Icon(Icons.refresh)),
        );
      },
    );
  }
}
