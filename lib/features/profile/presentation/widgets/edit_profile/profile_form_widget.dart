import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/validators/app_validators.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/inputs/app_dropdown_field.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';
import 'package:mustore/features/profile/domain/params/account/update_profile_params.dart';
import 'package:mustore/features/profile/presentation/widgets/edit_profile/picture_editor_widget.dart';
import 'package:mustore/generated/l10n.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({
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
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
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
          child: PictureEditorWidget(
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