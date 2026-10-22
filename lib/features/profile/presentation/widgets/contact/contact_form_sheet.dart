import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_state.dart';
import 'package:mustore/generated/l10n.dart';

class ContactFormSheet extends StatefulWidget {
  const ContactFormSheet({super.key, this.contact});

  final Contact? contact;

  @override
  State<ContactFormSheet> createState() => _ContactFormSheetState();
}

class _ContactFormSheetState extends State<ContactFormSheet> {
  static const _minLength = 7;
  static const _maxLength = 15;

  final _formKey = GlobalKey<FormState>();

  late final _phone = TextEditingController(text: widget.contact?.phoneNumber);

  bool get _isEdit => widget.contact != null;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  String? _validatePhone(String? v) {
    final l10n = S.of(context);
    final value = v?.trim() ?? '';

    if (value.isEmpty) return l10n.contactsFieldRequired;
    if (value.length < _minLength) return l10n.contactsPhoneInvalid;

    final duplicate = context.read<ContactCubit>().state.contacts.any(
          (c) => c.phoneNumber == value && c.id != widget.contact?.id,
    );
    return duplicate ? l10n.contactsPhoneDuplicate : null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<ContactCubit>();
    final phone = _phone.text.trim();

    if (_isEdit) {
      final old = widget.contact!;

      if (phone == old.phoneNumber) {
        Navigator.pop(context);
        return;
      }

      cubit.updateContact(
        UpdateContactParams(contactId: old.id, phoneNumber: phone),
        old.copyWith(phoneNumber: phone),
      );
    } else {
      cubit.addContact(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<ContactCubit, ContactState>(
      listenWhen: (p, c) => _isEdit
          ? p.updateStatus != c.updateStatus
          : p.addStatus != c.addStatus,
      listener: (context, state) {
        final status = _isEdit ? state.updateStatus : state.addStatus;
        if (status == RequestStatus.success) Navigator.pop(context);
      },
      child: AppForm(
        formKey: _formKey,
        children: [
          AppTextField(
            controller: _phone,
            label: l10n.contactsFieldPhone,
            hint: l10n.contactsPhoneHint,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: _maxLength,
            validator: _validatePhone,
          ),
          Dimens.gapLg,
          BlocSelector<ContactCubit, ContactState, bool>(
            selector: (state) =>
            (_isEdit ? state.updateStatus : state.addStatus) ==
                RequestStatus.loading,
            builder: (context, loading) => AppButton(
              label: _isEdit
                  ? l10n.contactsSaveChanges
                  : l10n.contactsAddAction,
              isLoading: loading,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}