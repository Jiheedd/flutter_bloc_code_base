
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/post_entity.dart';

class PostListWidget extends StatelessWidget {
  final List<PostEntity> posts;
  const PostListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Hero(
            tag: 'hero-tag-${posts[index].id}',
            child: Text(posts[index].id.toString()),
          ),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            // BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
            // print("on Tap posts index: $index");
            // BlocProvider.of<PostsBloc>(context).add(NavigateToFormEvent(true, post: posts[index]));

            context.goNamed('details', extra: posts[index]);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => PostDetailPage(post: posts[index]),
            //   ),
            // );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}