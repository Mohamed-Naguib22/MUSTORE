import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/inputs/app_dropdown_field.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_input_style.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_state.dart';
import 'package:mustore/features/profile/presentation/controllers/location/location_cubit.dart'; // adjust path
import 'package:mustore/features/profile/presentation/controllers/location/location_state.dart'; // adjust path
import 'package:mustore/generated/l10n.dart';

class AddressFormSheet extends StatefulWidget {
  const AddressFormSheet({super.key, this.address});

  final Address? address;

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final _street = TextEditingController(text: widget.address?.street);
  late final _building = TextEditingController(text: widget.address?.building);
  late final _apartment =
  TextEditingController(text: widget.address?.apartment);
  late final _floor = TextEditingController(text: widget.address?.floor);
  late final _additionalInfo =
  TextEditingController(text: widget.address?.additionalInfo);
  late final _postalCode =
  TextEditingController(text: widget.address?.postalCode);

  bool _isDefault = false;

  bool get _isEdit => widget.address != null;

  @override
  void dispose() {
    for (final c in [
      _street,
      _building,
      _apartment,
      _floor,
      _additionalInfo,
      _postalCode,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _nullIfEmpty(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : v;
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty)
      ? S.of(context).addressesFieldRequired
      : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final cityId = context.read<LocationCubit>().state.selectedCity?.id;
    if (cityId == null) return;

    final cubit = context.read<AddressCubit>();

    if (_isEdit) {
      cubit.updateAddress(
        UpdateAddressParams(
          id: widget.address!.id,
          street: _street.text.trim(),
          building: _nullIfEmpty(_building),
          apartment: _nullIfEmpty(_apartment),
          postalCode: _postalCode.text.trim(),
          cityId: cityId,
        ),
      );
    } else {
      cubit.addAddress(
        AddAddressParams(
          street: _street.text.trim(),
          building: _nullIfEmpty(_building),
          apartment: _nullIfEmpty(_apartment),
          floor: _nullIfEmpty(_floor),
          additionalInfo: _nullIfEmpty(_additionalInfo),
          postalCode: _postalCode.text.trim(),
          isDefault: _isDefault,
          cityId: cityId,
        ),
      );
    }
  }

  Widget _field(
      String label,
      TextEditingController controller, {
        String? hint,
        IconData? icon,
        String? Function(String?)? validator,
        TextInputType? keyboardType,
        TextInputAction action = TextInputAction.next,
        int maxLines = 1,
      }) {
    return AppInputStyle.labeled(
      context,
      label: label,
      field: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: action,
        maxLines: maxLines,
        style: AppInputStyle.textStyle(context),
        decoration: AppInputStyle.decoration(
          context,
          hint: hint,
          prefixIcon: icon,
          multiline: maxLines > 1,
        ),
      ),
    );
  }

  String? _errorFor(BuildContext context, RequestStatus status, LocationState s) {
    if (status != RequestStatus.failure) return null;
    final message = s.failure?.localizedMessage(context);
    return (message == null || message.isEmpty) ? null : message;
  }

  Widget _locationFields(BuildContext context, LocationState state) {
    final l10n = S.of(context);
    final location = context.read<LocationCubit>();

    final countryEnabled = state.countries.length > 1 &&
        !state.countriesStatus.isLoading;

    final governorateEnabled = state.selectedCountry != null &&
        state.governorates.isNotEmpty &&
        !state.governoratesStatus.isLoading;

    final cityEnabled = state.selectedGovernorate != null &&
        state.cities.isNotEmpty &&
        !state.citiesStatus.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppDropdownField<String>(
          key: ValueKey(
            'country-${state.selectedCountry?.id}-${state.countries.length}',
          ),
          label: l10n.profileFieldRequired,
          hint: l10n.addressesCountryHint,
          prefixIcon: Icons.public_rounded,
          initialValue: state.selectedCountry?.id,
          enabled: countryEnabled,
          errorText: _errorFor(context, state.countriesStatus, state),
          validator: (v) => v == null ? l10n.addressesCountryRequired : null,
          onChanged: (id) {
            for (final c in state.countries) {
              if (c.id == id) {
                location.selectCountry(c);
                break;
              }
            }
          },
          items: [
            for (final c in state.countries)
              DropdownMenuItem(value: c.id, child: Text(c.name)),
          ],
        ),
        Dimens.gapLg,
        AppDropdownField<String>(
          key: ValueKey(
            'gov-${state.selectedGovernorate?.id}-${state.governorates.length}',
          ),
          label: l10n.addressesFieldGovernorate,
          hint: l10n.addressesGovernorateHint,
          prefixIcon: Icons.map_outlined,
          initialValue: state.selectedGovernorate?.id,
          enabled: governorateEnabled,
          errorText: _errorFor(context, state.governoratesStatus, state),
          validator: (v) =>
          v == null ? l10n.addressesGovernorateRequired : null,
          onChanged: (id) {
            for (final g in state.governorates) {
              if (g.id == id) {
                location.selectGovernorate(g);
                break;
              }
            }
          },
          items: [
            for (final g in state.governorates)
              DropdownMenuItem(value: g.id, child: Text(g.name)),
          ],
        ),
        Dimens.gapLg,
        AppDropdownField<String>(
          key: ValueKey(
            'city-${state.selectedCity?.id}-${state.cities.length}',
          ),
          label: l10n.addressesFieldCity,
          hint: l10n.addressesCityHint,
          prefixIcon: Icons.location_city_rounded,
          initialValue: state.selectedCity?.id,
          enabled: cityEnabled,
          errorText: _errorFor(context, state.citiesStatus, state),
          validator: (v) => v == null ? l10n.addressesCityRequired : null,
          onChanged: (id) {
            for (final c in state.cities) {
              if (c.id == id) {
                location.selectCity(c);
                break;
              }
            }
          },
          items: [
            for (final c in state.cities)
              DropdownMenuItem(value: c.id, child: Text(c.name)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final l10n = S.of(context);

    return BlocListener<AddressCubit, AddressState>(
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
          _field(
            l10n.addressesFieldStreet,
            _street,
            hint: l10n.addressesStreetHint,
            icon: Icons.signpost_outlined,
            validator: _required,
          ),
          Dimens.gapLg,
          BlocBuilder<LocationCubit, LocationState>(
            builder: _locationFields,
          ),
          Dimens.gapLg,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _field(l10n.addressesFieldBuilding, _building),
              ),
              Dimens.gapMd,
              Expanded(
                child: _field(l10n.addressesFieldApartment, _apartment),
              ),
            ],
          ),
          if (!_isEdit) ...[
            Dimens.gapLg,
            _field(l10n.addressesFieldFloor, _floor),
          ],
          Dimens.gapLg,
          _field(
            l10n.addressesFieldPostalCode,
            _postalCode,
            icon: Icons.markunread_mailbox_outlined,
            keyboardType: TextInputType.number,
            validator: _required,
            action: _isEdit ? TextInputAction.done : TextInputAction.next,
          ),
          if (!_isEdit) ...[
            Dimens.gapLg,
            _field(
              l10n.addressesFieldAdditionalInfo,
              _additionalInfo,
              hint: l10n.addressesAdditionalInfoHint,
              maxLines: 3,
              action: TextInputAction.done,
            ),
            Dimens.gapMd,
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _isDefault,
              onChanged: (v) => setState(() => _isDefault = v),
              title: Text(
                l10n.addressesSetAsDefault,
                style: theme.textTheme.bodyMedium,
              ),
              activeTrackColor: s.primary,
            ),
          ],
          Dimens.gapLg,
          BlocSelector<AddressCubit, AddressState, bool>(
            selector: (state) =>
            (_isEdit ? state.updateStatus : state.addStatus) ==
                RequestStatus.loading,
            builder: (context, loading) => AppButton(
              label: _isEdit
                  ? l10n.addressesSaveChanges
                  : l10n.addressesAddAction,
              isLoading: loading,
              onPressed: _submit,
            ),
          ),
          Dimens.gapLg,
        ],
      ),
    );
  }
}