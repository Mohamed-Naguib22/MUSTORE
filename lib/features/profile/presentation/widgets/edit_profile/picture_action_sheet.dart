import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/generated/l10n.dart';

enum PictureAction { gallery, remove }

class PictureActionSheet extends StatelessWidget {
  const PictureActionSheet({super.key, required this.canRemove});

  final bool canRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppListTile(
            icon: Icons.photo_library_outlined,
            title: l10n.profileChooseGallery,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(PictureAction.gallery),
          ),
          if (canRemove)
            AppListTile(
              icon: Icons.delete_outline_rounded,
              title: l10n.profileRemovePhoto,
              isDestructive: true,
              showChevron: false,
              onTap: () => Navigator.of(context).pop(PictureAction.remove),
            ),
        ],
      ),
    );
  }
}