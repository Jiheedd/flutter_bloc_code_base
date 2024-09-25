import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../bloc/add_delete_update_post/form_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final PostEntity? post;

  const FormWidget({
    super.key,
    required this.isUpdatePost,
    this.post,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormFieldWidget(
                  name: "title".tr(context), multiLines: false, controller: _titleController),
              TextFormFieldWidget(
                  name: "body".tr(context), multiLines: true, controller: _bodyController),
              FormSubmitBtn(
                  isUpdatePost: widget.isUpdatePost,
                  onPressed: validateFormThenUpdateOrAddPost),
            ]),
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = PostEntity(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<FormPostBloc>(context)
            .add(UpdatePostEvent(post: post,successMessage: "update_post_success".tr(context)));
      } else {
        BlocProvider.of<FormPostBloc>(context)
            .add(AddPostEvent(post: post, successMessage: "add_post_success".tr(context)));
      }
    }
  }
}