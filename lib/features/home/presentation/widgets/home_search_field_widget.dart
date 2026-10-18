import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/generated/l10n.dart';

class HomeSearchFieldWidget extends StatelessWidget {
  const HomeSearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.lg,
        Dimens.md,
        Dimens.lg,
        Dimens.lg,
      ),
      child: AppTextField(
        readOnly: true,
        hint: S.of(context).homeSearchHint,
        prefixIcon: Icons.search_rounded,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
        ),
        onTap: () {},
      ),
    );
  }
}
