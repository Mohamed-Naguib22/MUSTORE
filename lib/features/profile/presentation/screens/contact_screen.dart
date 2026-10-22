import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_confirmation_sheet.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/lists/app_list_view.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_state.dart';
import 'package:mustore/features/profile/presentation/widgets/contact/contact_card.dart';
import 'package:mustore/features/profile/presentation/widgets/contact/contact_form_sheet.dart';
import 'package:mustore/features/profile/presentation/widgets/contact/contact_verify_sheet.dart';
import 'package:mustore/generated/l10n.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _openForm(BuildContext context, {Contact? contact}) {
    final cubit = context.read<ContactCubit>();
    final l10n = S.of(context);

    return AppBottomSheet.show<void>(
      context,
      title: contact == null ? l10n.contactsAddTitle : l10n.contactsEditTitle,
      icon: contact == null ? Icons.add_call : Icons.edit_rounded,
      child: BlocProvider.value(
        value: cubit,
        child: ContactFormSheet(contact: contact),
      ),
    );
  }

  Future<void> _openVerify(BuildContext context, Contact contact) {
    final cubit = context.read<ContactCubit>();
    final l10n = S.of(context);

    cubit.sendVerificationCode(contact.id);

    return AppBottomSheet.show<void>(
      context,
      title: l10n.contactsVerifyTitle,
      icon: Icons.verified_user_outlined,
      child: BlocProvider.value(
        value: cubit,
        child: ContactVerifySheet(contact: contact),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Contact contact) async {
    final cubit = context.read<ContactCubit>();
    final l10n = S.of(context);

    final confirmed = await AppConfirmationSheet.show(
      context,
      title: l10n.contactsDeleteTitle,
      message: l10n.contactsDeleteMessage(contact.phoneNumber),
      confirmLabel: l10n.contactsDelete,
      cancelLabel: l10n.contactsCancel,
      icon: Icons.delete_outline_rounded,
      isDestructive: true,
    );

    if (confirmed) cubit.deleteContact(contact.id);
  }

  void _toastOnChange(
      BuildContext context,
      ContactState state,
      RequestStatus status,
      String successMessage,
      ) {
    if (status == RequestStatus.success) {
      AppToast.success(context, successMessage);
      return;
    }

    if (status == RequestStatus.failure) {
      final message = state.failure?.localizedMessage(context) ?? '';
      if (message.isNotEmpty) AppToast.error(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.addStatus != c.addStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.addStatus, l10n.contactsAdded),
        ),
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.updateStatus != c.updateStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.updateStatus, l10n.contactsUpdated),
        ),
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.setPrimaryStatus != c.setPrimaryStatus,
          listener: (context, s) => _toastOnChange(
            context,
            s,
            s.setPrimaryStatus,
            l10n.contactsPrimaryChanged,
          ),
        ),
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.deleteStatus != c.deleteStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.deleteStatus, l10n.contactsDeleted),
        ),
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.sendCodeStatus != c.sendCodeStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.sendCodeStatus, l10n.contactsCodeSent),
        ),
        BlocListener<ContactCubit, ContactState>(
          listenWhen: (p, c) => p.verifyStatus != c.verifyStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.verifyStatus, l10n.contactsVerified),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ContactCubit, ContactState>(
              buildWhen: (p, c) =>
              p.status != c.status ||
                  !listEquals(
                    p.contacts.map((c) => c.id).toList(),
                    c.contacts.map((c) => c.id).toList(),
                  ),
              builder: (context, state) {
                final cubit = context.read<ContactCubit>();
                final isLoading = state.status == RequestStatus.loading ||
                    state.status == RequestStatus.initial;

                if (state.status == RequestStatus.failure &&
                    state.contacts.isEmpty) {
                  final message = state.failure?.localizedMessage(context);

                  return Center(
                    child: AppMessageWidget(
                      title: l10n.contactsLoadFailedTitle,
                      message: (message == null || message.isEmpty)
                          ? l10n.failureGeneric
                          : message,
                      actionLabel: l10n.contactsRetry,
                      onAction: cubit.fetchContacts,
                    ),
                  );
                }

                if (isLoading) {
                  return AppSkeleton(
                    isLoading: true,
                    child: AppListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          ContactCard(
                            contact: Contact.fake(
                              isPrimary: i == 0,
                              isVerified: i != 1,
                            ),
                            onEdit: () {},
                            onDelete: () {},
                            onSetPrimary: () {},
                            onVerify: () {},
                          ),
                          Dimens.gapMd,
                        ],
                      ],
                    ),
                  );
                }

                if (state.contacts.isEmpty) {
                  return const _EmptyContacts();
                }

                return RefreshIndicator(
                  onRefresh: () => cubit.fetchContacts(),
                  child: AppListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (final contact in state.contacts) ...[
                        BlocBuilder<ContactCubit, ContactState>(
                          key: ValueKey(contact.id),
                          buildWhen: (p, c) =>
                          p.contactById(contact.id) !=
                              c.contactById(contact.id),
                          builder: (context, state) {
                            final current = state.contactById(contact.id);
                            if (current == null) return const SizedBox.shrink();

                            return ContactCard(
                              contact: current,
                              onEdit: () => _openForm(context, contact: current),
                              onDelete: () => _confirmDelete(context, current),
                              onSetPrimary: current.isPrimary
                                  ? null
                                  : () => context
                                  .read<ContactCubit>()
                                  .setContactAsPrimary(current.id),
                              onVerify: current.isVerified
                                  ? null
                                  : () => _openVerify(context, current),
                            );
                          },
                        ),
                        Dimens.gapMd,
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: Dimens.screen,
            child: AppButton(
              label: l10n.contactsAddNew,
              icon: Icons.add_rounded,
              onPressed: () => _openForm(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyContacts extends StatelessWidget {
  const _EmptyContacts();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final l10n = S.of(context);

    return Center(
      child: Padding(
        padding: Dimens.screen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimens.iconXl,
              height: Dimens.iconXl,
              decoration: BoxDecoration(
                color: s.primaryContainer,
                borderRadius: Dimens.borderXl,
              ),
              child: Icon(
                Icons.phone_outlined,
                size: Dimens.iconLg,
                color: s.onPrimaryContainer,
              ),
            ),
            Dimens.gapLg,
            Text(l10n.contactsEmptyTitle, style: theme.textTheme.titleMedium),
            Dimens.gapXs,
            Text(
              l10n.contactsEmptyMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: s.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}