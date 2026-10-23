import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/services/media/file_picker_helper.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/lists/app_list_view.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_state.dart';
import 'package:mustore/features/profile/presentation/widgets/edit_profile/picture_action_sheet.dart';
import 'package:mustore/features/profile/presentation/widgets/edit_profile/profile_form_widget.dart';
import 'package:mustore/generated/l10n.dart';

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

    final action = await PictureActionSheet.show(
      context,
      canRemove: !profile.isDefaultPicture,
    );

    if (action == null || !context.mounted) return;

    if (action == PictureAction.remove) {
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
            padding: const EdgeInsetsDirectional.fromSTEB(
              Dimens.lg,
              Dimens.xxl,
              Dimens.lg,
              Dimens.xl,
            ),
            children: [
              AppSkeleton(
                isLoading: loading,
                child: IgnorePointer(
                  ignoring: loading,
                  child: ProfileFormWidget(
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
                        : () => _onPictureTap(context, profile,),
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
