import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.multiLines,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          minLines: multiLines ? 6 : 1,
          maxLines: multiLines ? 6 : 1,
          controller: controller,
          validator: (val) => val!.isEmpty ? (name + "cant_be_empty".tr(context)) : null,
          decoration: InputDecoration(hintText: name),
        ));
  }
}