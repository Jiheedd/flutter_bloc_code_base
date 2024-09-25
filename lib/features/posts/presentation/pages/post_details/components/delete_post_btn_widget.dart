import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/app_localizations.dart';
import '../../../../../../core/widgets/snackbar_message.dart';
import '../../../../../../core/widgets/loading_widget.dart';
import '../../../bloc/add_delete_update_post/form_post_bloc.dart';
import '../../posts/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;

  const DeletePostBtnWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      // label: const Text("Delete"),
      label: Text("delete".tr(context)),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<FormPostBloc, FormPostState>(
          listener: (context, state) {
            if (state is MessageFormPostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsPage(),
                  ),
                  (route) => false);
            } else if (state is ErrorFormPostState) {
              Navigator.of(context).pop();
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingFormPostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}