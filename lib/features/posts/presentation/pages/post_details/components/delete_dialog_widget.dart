import '../../../../../../core/util/app_localizations.dart';
import '../../../bloc/add_delete_update_post/form_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: const Text("Are you Sure ?"),
      title: Text(
        "are_u_sure".tr(context),
        // "are_u_sure".tr(context),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("no".tr(context),
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<FormPostBloc>(context).add(
              DeletePostEvent(postId: postId, successMessage: "delete_post_success".tr(context)),
            );
          },
          child: Text("yes".tr(context)),
        ),
      ],
    );
  }
}