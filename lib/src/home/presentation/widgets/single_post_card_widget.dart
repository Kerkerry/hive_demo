import 'package:buub/src/home/domain/entities/post.dart';
import 'package:flutter/material.dart';

class SinglePostCardWidget extends StatelessWidget {
  const SinglePostCardWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        title: Text(
          post.title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 2),
        ),
        subtitle: Text(
          post.body,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
