import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_state.dart';
import 'package:mustore/features/profile/presentation/widgets/account/contact_section_widget.dart';
import 'package:mustore/features/profile/presentation/widgets/account/preferences_section_widget.dart';
import 'package:mustore/features/profile/presentation/widgets/account/profile_section_widget.dart';
import 'package:mustore/features/profile/presentation/widgets/account/security_section_widget.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) => c.failure != null && p.failure != c.failure,
          listener: (context, state) =>
              AppToast.error(context, state.failure!.localizedMessage(context)),
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (p, c) => c.profile != null && p.profile != c.profile,
          listener: (context, state) {
            final profile = state.profile!;
            context.read<AuthCubit>().syncProfile(
              firstName: profile.firstName,
              lastName: profile.lastName,
              profilePictureUrl: profile.profilePictureUrl,
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (p, c) =>
          c.action == AuthAction.revokeSession &&
              c.status == RequestStatus.success &&
              p.status != RequestStatus.success,
          listener: (context, state) =>
              AppToast.success(context, l10n.logoutSuccess),
        ),
      ],
      child: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: Dimens.lg,
          end: Dimens.lg,
          top: Dimens.lg,
          bottom: Dimens.xl,
        ),
        children: const [
          ProfileSectionWidget(),
          ContactSectionWidget(),
          PreferencesSectionWidget(),
          SecuritySectionWidget(),
        ],
      ),
    );
  }
}