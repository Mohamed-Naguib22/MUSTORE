import 'package:flutter/material.dart';

class AppForm extends StatelessWidget {
  const AppForm({
    super.key,
    required this.formKey,
    required this.children,
    this.autovalidateMode,
    this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}