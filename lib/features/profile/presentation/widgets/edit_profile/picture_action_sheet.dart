import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_options_sheet.dart';
import 'package:mustore/generated/l10n.dart';

enum PictureAction { gallery, remove }

abstract final class PictureActionSheet {
  static Future<PictureAction?> show(
      BuildContext context, {
        required bool canRemove,
      }) {
    final l10n = S.of(context);

    return AppOptionsSheet.show<PictureAction>(
      context,
      options: [
        AppOption(
          value: PictureAction.gallery,
          label: l10n.profileChooseGallery,
          icon: Icons.photo_library_outlined,
        ),
        if (canRemove)
          AppOption(
            value: PictureAction.remove,
            label: l10n.profileRemovePhoto,
            icon: Icons.delete_outline_rounded,
            isDestructive: true,
          ),
      ],
    );
  }
}