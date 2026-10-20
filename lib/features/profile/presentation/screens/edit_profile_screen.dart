import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/services/media/file_picker_helper.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/validators/app_validators.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_dropdown_field.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/core/widgets/lists/app_list_view.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';
import 'package:mustore/features/profile/domain/params/update_profile_params.dart';
import 'package:mustore/features/profile/presentation/controllers/profile_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/profile_state.dart';
import 'package:mustore/generated/l10n.dart';

enum _PictureAction { gallery, remove }

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static String _bust(String url, int version) {
    if (version == 0 || url.isEmpty) return url;
    return '$url${url.contains('?') ? '&' : '?'}v=$version';
  }

  static void _toastFailure(BuildContext context, ProfileState state) {
    final failure = state.failure;
    if (failure != null) {
      AppToast.error(context, failure.localizedMessage(context));
    }
  }

  Future<void> _onPictureTap(BuildContext context, UserProfile profile) async {
    final cubit = context.read<ProfileCubit>();

    final action = await showModalBottomSheet<_PictureAction>(
      context: context,
      builder: (_) => _PictureSheet(canRemove: !profile.isDefaultPicture),
    );
    if (action == null || !context.mounted) return;

    if (action == _PictureAction.remove) {
      await cubit.deleteProfilePicture();
      return;
    }

    await FilePickerHelper.pickFiles(
      context: context,
      fileTypeGroups: [FileTypeGroup.image],
      maxFiles: 1,
      maxFileSizeInMB: 5,
      onError: (message) => AppToast.error(context, message),
      onFilesSelected: (files) {
        final path = files.first.path;
        if (path == null) {
          AppToast.error(context, S.of(context).profilePickFailed);
          return;
        }
        cubit.setProfilePicture(path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (p, c) => p.updateStatus != c.updateStatus,
          listener: (context, state) {
            switch (state.updateStatus) {
              case RequestStatus.success:
                AppToast.success(context, l10n.profileUpdated);
              case RequestStatus.failure:
                _toastFailure(context, state);
              default:
                break;
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (p, c) => p.pictureStatus != c.pictureStatus,
          listener: (context, state) {
            switch (state.pictureStatus) {
              case RequestStatus.success:
                AppToast.success(context, l10n.profilePictureUpdated);
              case RequestStatus.failure:
                _toastFailure(context, state);
              default:
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final profile = state.profile;
          final failed =
              profile == null && state.status == RequestStatus.failure;
          final loading = profile == null && !failed;

          if (failed) {
            return AppListView(
              children: [
                AppMessageWidget(
                  message: state.failure?.localizedMessage(context) ?? '',
                  actionLabel: l10n.commonRetry,
                  onAction: () => context.read<ProfileCubit>().fetchProfile(),
                  margin: EdgeInsets.zero,
                ),
              ],
            );
          }

          return AppListView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimens.lg,
              vertical: Dimens.xl,
            ),
            children: [
              AppSkeleton(
                isLoading: loading,
                child: IgnorePointer(
                  ignoring: loading,
                  child: _ProfileForm(
                    key: ValueKey(loading),
                    profile: profile ?? const UserProfile.fake(),
                    pictureUrl: _bust(
                      profile?.profilePictureUrl ?? '',
                      state.pictureVersion,
                    ),
                    isSaving: state.updateStatus == RequestStatus.loading,
                    isPictureBusy: state.pictureStatus == RequestStatus.loading,
                    onPictureTap: profile == null
                        ? null
                        : () => _onPictureTap(context, profile),
                    onSave: context.read<ProfileCubit>().updateProfile,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({
    super.key,
    required this.profile,
    required this.pictureUrl,
    required this.isSaving,
    required this.isPictureBusy,
    required this.onPictureTap,
    required this.onSave,
  });

  final UserProfile profile;
  final String pictureUrl;
  final bool isSaving;
  final bool isPictureBusy;
  final VoidCallback? onPictureTap;
  final ValueChanged<UpdateProfileParams> onSave;

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final _first = TextEditingController(text: widget.profile.firstName);
  late final _last = TextEditingController(text: widget.profile.lastName);
  late final _email = TextEditingController(text: widget.profile.email);
  late final _gender = ValueNotifier<Gender>(widget.profile.gender);

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _gender.dispose();
    super.dispose();
  }

  bool get _dirty =>
      _first.text.trim() != widget.profile.firstName ||
          _last.text.trim() != widget.profile.lastName ||
          _gender.value != widget.profile.gender;

  String _genderLabel(Gender g, S l10n) => switch (g) {
    Gender.male => l10n.genderMale,
    Gender.female => l10n.genderFemale,
  };

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final p = widget.profile;
    final first = _first.text.trim();
    final last = _last.text.trim();

    widget.onSave(
      UpdateProfileParams(
        firstName: first != p.firstName ? first : null,
        lastName: last != p.lastName ? last : null,
        gender: _gender.value != p.gender ? _gender.value : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final required = AppValidators.required(l10n.profileFieldRequired);

    return AppForm(
      formKey: _formKey,
      children: [
        Center(
          child: _PictureEditor(
            url: widget.pictureUrl,
            isBusy: widget.isPictureBusy,
            onTap: widget.onPictureTap,
          ),
        ),
        Dimens.gapXl,
        AppTextField(
          controller: _email,
          label: l10n.profileEmail,
          prefixIcon: Icons.mail_outline_rounded,
          suffixIcon: Icon(
            Icons.lock_outline_rounded,
            size: Dimens.iconMd - Dimens.xs,
            color: scheme.onSurfaceVariant,
          ),
          textDirection: TextDirection.ltr,
          readOnly: true,
          enabled: false,
        ),
        Dimens.gapLg,
        AppTextField(
          controller: _first,
          label: l10n.profileFirstName,
          prefixIcon: Icons.person_outline_rounded,
          textInputAction: TextInputAction.next,
          validator: required,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        Dimens.gapLg,
        AppTextField(
          controller: _last,
          label: l10n.profileLastName,
          prefixIcon: Icons.person_outline_rounded,
          textInputAction: TextInputAction.done,
          validator: required,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        Dimens.gapLg,
        AppDropdownField<Gender>(
          label: l10n.profileGender,
          prefixIcon: Icons.wc_rounded,
          initialValue: _gender.value,
          items: [
            for (final g in Gender.values)
              DropdownMenuItem(value: g, child: Text(_genderLabel(g, l10n))),
          ],
          onChanged: (g) {
            if (g != null) _gender.value = g;
          },
        ),
        Dimens.gapXl,
        ListenableBuilder(
          listenable: Listenable.merge([_first, _last, _gender]),
          builder: (context, _) => AppButton(
            label: l10n.profileSave,
            icon: Icons.check_rounded,
            isLoading: widget.isSaving,
            onPressed: _dirty ? _save : null,
          ),
        ),
      ],
    );
  }
}

class _PictureEditor extends StatelessWidget {
  const _PictureEditor({
    required this.url,
    required this.isBusy,
    required this.onTap,
  });

  final String url;
  final bool isBusy;
  final VoidCallback? onTap;

  static const double _size = Dimens.iconXl;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: isBusy ? null : onTap,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: ClipOval(
                child: AppNetworkImage(
                  url: url,
                  width: _size,
                  height: _size,
                  fallbackIcon: Icons.person_rounded,
                ),
              ),
            ),
            if (isBusy)
              Positioned.fill(
                child: ClipOval(
                  child: ColoredBox(
                    color: scheme.scrim.withValues(alpha: 0.4),
                    child: const Center(
                      child: SizedBox(
                        width: Dimens.iconMd - Dimens.xs,
                        height: Dimens.iconMd - Dimens.xs,
                        child: CircularProgressIndicator(
                          strokeWidth: Dimens.xxs,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            PositionedDirectional(
              end: -Dimens.xxs,
              bottom: -Dimens.xxs,
              child: Container(
                width: Dimens.xl,
                height: Dimens.xl,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: background, width: Dimens.xxs),
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: Dimens.iconSm - Dimens.xxs,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PictureSheet extends StatelessWidget {
  const _PictureSheet({required this.canRemove});

  final bool canRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: Dimens.sm,
          end: Dimens.sm,
          bottom: Dimens.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppListTile(
              icon: Icons.photo_library_outlined,
              title: l10n.profileChooseGallery,
              showChevron: false,
              onTap: () => Navigator.of(context).pop(_PictureAction.gallery),
            ),
            if (canRemove)
              AppListTile(
                icon: Icons.delete_outline_rounded,
                title: l10n.profileRemovePhoto,
                isDestructive: true,
                showChevron: false,
                onTap: () => Navigator.of(context).pop(_PictureAction.remove),
              ),
          ],
        ),
      ),
    );
  }
}