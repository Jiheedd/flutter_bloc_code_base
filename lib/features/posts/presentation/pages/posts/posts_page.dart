
import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';

import '../../../../../core/widgets/internet_bloc_listener.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_post/form_post_bloc.dart';
import '../../bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/message_display_widget.dart';
import 'components/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) => AppBar(
        title: Text('posts'.tr(context)),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InternetBlocListener(
        eventOnline: _onRefresh,
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsInitial) {
              context.read<PostsBloc>().add(GetAllPostsEvent());
            } else if (state is LoadingPostsState) {
              return const LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.posts),
              );
            } else if (state is ErrorPostsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ListView(
                  children: [MessageDisplayWidget(message: state.message)],
                ),
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<PostsBloc>().add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<FormPostBloc>().add(const NavigatingToFormEvent(false));
      },
      child: const Icon(Icons.add),
    );
  }
}