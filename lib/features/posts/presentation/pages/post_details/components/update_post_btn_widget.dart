import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../app/injection_container.dart';
import '../../../../../../core/util/app_localizations.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../bloc/add_delete_update_post/form_post_bloc.dart';
import '../../../bloc/posts/posts_bloc.dart';
import '../../post_form/post_form_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final PostEntity post;

  const UpdatePostBtnWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // sl<PostsBloc>().add(NavigatingToFormState);
        sl<FormPostBloc>().add(NavigatingToFormEvent(true, post: post));
        // context.read<FormPostBloc>().add(NavigatingToFormEvent(true, post: post));

      },
      icon: const Icon(Icons.edit),
      label: Text("edit".tr(context)),
    );
  }
}