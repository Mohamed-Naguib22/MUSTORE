import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/icons/app_icon_badge.dart';
import 'package:mustore/core/widgets/inputs/app_dropdown_field.dart';
import 'package:mustore/core/widgets/inputs/app_form.dart';
import 'package:mustore/core/widgets/inputs/app_input_style.dart';
import 'package:mustore/core/widgets/inputs/app_switch.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_state.dart';
import 'package:mustore/features/profile/presentation/controllers/location/location_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/location/location_state.dart';
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

  final _isDefault = ValueNotifier<bool>(false);

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
    _isDefault.dispose();
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

    final location = context.read<LocationCubit>().state;
    final city = location.selectedCity;
    if (city == null) return;

    final cubit = context.read<AddressCubit>();
    final canSetDefault = cubit.state.defaultAddress == null;

    if (_isEdit) {
      final old = widget.address!;
      final governorate = location.selectedGovernorate;
      final country = location.selectedCountry;

      final updated = Address(
        id: old.id,
        street: _street.text.trim(),
        building: _nullIfEmpty(_building),
        apartment: _nullIfEmpty(_apartment),
        floor: old.floor,
        additionalInfo: old.additionalInfo,
        postalCode: _postalCode.text.trim(),
        isDefault: old.isDefault,
        city: city.name,
        governorate: governorate?.name ?? old.governorate,
        cityId: city.id,
        governorateId: governorate?.id ?? old.governorateId,
        countryId: country?.id ?? old.countryId,
      );

      cubit.updateAddress(
        UpdateAddressParams(
          id: old.id,
          street: updated.street,
          building: updated.building,
          apartment: updated.apartment,
          postalCode: updated.postalCode,
          cityId: city.id,
        ),
        updated,
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
          isDefault: canSetDefault && _isDefault.value,
          cityId: city.id,
        ),
      );
    }
  }

  String? _errorFor(
      BuildContext context, RequestStatus status, LocationState s) {
    if (status != RequestStatus.failure) return null;
    final message = s.failure?.localizedMessage(context);
    return (message == null || message.isEmpty) ? null : message;
  }

  Widget _locationFields(BuildContext context, LocationState state) {
    final l10n = S.of(context);
    final location = context.read<LocationCubit>();

    final countryEnabled =
        state.countries.length > 1 && !state.countriesStatus.isLoading;

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
          label: l10n.addressesFieldCountry,
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
    final hasDefault = context.select<AddressCubit, bool>(
          (c) => c.state.defaultAddress != null,
    );

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
          AppTextField(
            controller: _street,
            label: l10n.addressesFieldStreet,
            hint: l10n.addressesStreetHint,
            prefixIcon: Icons.signpost_outlined,
            textInputAction: TextInputAction.next,
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
                child: AppTextField(
                  controller: _building,
                  label: l10n.addressesFieldBuilding,
                  hint: l10n.addressesBuildingHint,
                  prefixIcon: Icons.apartment_rounded,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Dimens.gapMd,
              Expanded(
                child: AppTextField(
                  controller: _apartment,
                  label: l10n.addressesFieldApartment,
                  hint: l10n.addressesApartmentHint,
                  prefixIcon: Icons.door_front_door_outlined,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
          if (!_isEdit) ...[
            Dimens.gapLg,
            AppTextField(
              controller: _floor,
              label: l10n.addressesFieldFloor,
              hint: l10n.addressesFloorHint,
              prefixIcon: Icons.stairs_outlined,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
          Dimens.gapLg,
          AppTextField(
            controller: _postalCode,
            label: l10n.addressesFieldPostalCode,
            hint: l10n.addressesPostalCodeHint,
            prefixIcon: Icons.markunread_mailbox_outlined,
            keyboardType: TextInputType.number,
            textInputAction:
            _isEdit ? TextInputAction.done : TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 5,
            validator: _required,
          ),
          if (!_isEdit) ...[
            Dimens.gapLg,
            AppTextField(
              controller: _additionalInfo,
              label: l10n.addressesFieldAdditionalInfo,
              hint: l10n.addressesAdditionalInfoHint,
              prefixIcon: Icons.notes_rounded,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            if (!hasDefault) ...[
              Dimens.gapLg,
              ValueListenableBuilder<bool>(
                valueListenable: _isDefault,
                builder: (context, isDefault, _) => Material(
                  color: s.surfaceContainerHighest,
                  borderRadius: Dimens.borderMd,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _isDefault.value = !isDefault,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: Dimens.buttonHeight),
                      child: Row(
                        children: [
                          AppIconBadge(
                            icon: isDefault
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            isHighlighted: isDefault,
                            showBackground: false,
                            size: kMinInteractiveDimension,
                            iconSize: AppInputStyle.iconSize,
                          ),
                          Expanded(
                            child: Text(
                              l10n.addressesSetAsDefault,
                              style: AppInputStyle.textStyle(context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: Dimens.lg),
                            child: AppSwitch(
                              value: isDefault,
                              onChanged: (v) => _isDefault.value = v,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
        ],
      ),
    );
  }
}