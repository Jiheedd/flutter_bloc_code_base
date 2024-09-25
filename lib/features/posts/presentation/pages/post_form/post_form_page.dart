import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/snackbar_message.dart';
import '../../bloc/add_delete_update_post/form_post_bloc.dart';
import 'components/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          // sl<GoRouter>().replaceNamed("home");
          sl<GoRouter>().pop();
        },
      ),
      title: Text(
        isUpdatePost ? "edit_post".tr(context) : "add_post".tr(context),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<FormPostBloc, FormPostState>(
          listener: (context, state) {
            if (state is MessageFormPostState) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (_) => const PostsPage()),
              //   (route) => false,
              // );
              context.pushReplacementNamed('home');
            } else if (state is ErrorFormPostState) {
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingFormPostState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}