import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/post_entity.dart';
import 'components/post_detail_widget.dart';


class PostDetailPage extends StatelessWidget {
  final PostEntity post;
  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text("post_details".tr(context)),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}