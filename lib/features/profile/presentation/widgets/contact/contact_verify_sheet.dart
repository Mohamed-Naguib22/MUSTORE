import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_state.dart';
import 'package:mustore/generated/l10n.dart';

class ContactVerifySheet extends StatefulWidget {
  const ContactVerifySheet({super.key, required this.contact});

  final Contact contact;

  @override
  State<ContactVerifySheet> createState() => _ContactVerifySheetState();
}

class _ContactVerifySheetState extends State<ContactVerifySheet> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty)
      ? S.of(context).contactsFieldRequired
      : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ContactCubit>().verifyContact(
      contactId: widget.contact.id,
      otp: _code.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return BlocListener<ContactCubit, ContactState>(
      listenWhen: (p, c) => p.verifyStatus != c.verifyStatus,
      listener: (context, state) {
        if (state.verifyStatus == RequestStatus.success) {
          Navigator.pop(context);
        }
      },
      child: AppForm(
        formKey: _formKey,
        children: [
          Text(
            l10n.contactsVerifyMessage(widget.contact.phoneNumber),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Dimens.gapLg,
          AppTextField(
            controller: _code,
            label: l10n.contactsFieldCode,
            hint: l10n.contactsCodeHint,
            prefixIcon: Icons.pin_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 6,
            validator: _required,
          ),
          Dimens.gapLg,
          BlocSelector<ContactCubit, ContactState, bool>(
            selector: (state) => state.verifyStatus == RequestStatus.loading,
            builder: (context, loading) => AppButton(
              label: l10n.contactsVerifySubmit,
              isLoading: loading,
              onPressed: _submit,
            ),
          ),
          Dimens.gapMd,
          BlocSelector<ContactCubit, ContactState, bool>(
            selector: (state) => state.sendCodeStatus == RequestStatus.loading,
            builder: (context, loading) => AppButton(
              label: l10n.contactsResendCode,
              icon: Icons.refresh_rounded,
              variant: AppButtonVariant.tonal,
              isLoading: loading,
              onPressed: () => context
                  .read<ContactCubit>()
                  .sendVerificationCode(widget.contact.id),
            ),
          ),
        ],
      ),
    );
  }
}