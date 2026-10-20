import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/profile/presentation/widgets/profile_card_widget.dart';
import 'package:mustore/generated/l10n.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, AuthSession?>(
      selector: (state) => state.session,
      builder: (context, session) => ProfileCardWidget(
        session: session,
        editTooltip: S.of(context).accountEditProfile,
        onEdit: () {},
      ),
    );
  }
}