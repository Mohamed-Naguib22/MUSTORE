import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/app/di/injection.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/lists/app_list_view.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_state.dart';
import 'package:mustore/features/profile/presentation/controllers/location/location_cubit.dart';
import 'package:mustore/features/profile/presentation/widgets/address/address_card.dart';
import 'package:mustore/features/profile/presentation/widgets/address/address_form_sheet.dart';
import 'package:mustore/generated/l10n.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  Future<void> _openForm(BuildContext context, {Address? address}) {
    final cubit = context.read<AddressCubit>();
    final l10n = S.of(context);

    return AppBottomSheet.show<void>(
      context,
      title: address == null ? l10n.addressesAddTitle : l10n.addressesEditTitle,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: cubit),
          BlocProvider(
            create: (_) => sl<LocationCubit>()
              ..fetchCountries(
                countryId: address?.countryId,
                governorateId: address?.governorateId,
                cityId: address?.cityId,
              ),
          ),
        ],
        child: AddressFormSheet(address: address),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Address address) {
    final cubit = context.read<AddressCubit>();
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return AppBottomSheet.show<void>(
      context,
      title: l10n.addressesDeleteTitle,
      scrollable: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: Dimens.lg),
        child: Text(
          l10n.addressesDeleteMessage(address.street, address.city),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      footer: Builder(
        builder: (sheetContext) => Row(
          children: [
            Expanded(
              child: AppButton(
                label: l10n.addressesCancel,
                variant: AppButtonVariant.tonal,
                onPressed: () => Navigator.pop(sheetContext),
              ),
            ),
            Dimens.gapMd,
            Expanded(
              child: AppButton(
                label: l10n.addressesDelete,
                variant: AppButtonVariant.danger,
                onPressed: () {
                  Navigator.pop(sheetContext);
                  cubit.deleteAddress(address.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toastOnChange(
      BuildContext context,
      AddressState state,
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
        BlocListener<AddressCubit, AddressState>(
          listenWhen: (p, c) => p.addStatus != c.addStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.addStatus, l10n.addressesAdded),
        ),
        BlocListener<AddressCubit, AddressState>(
          listenWhen: (p, c) => p.updateStatus != c.updateStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.updateStatus, l10n.addressesUpdated),
        ),
        BlocListener<AddressCubit, AddressState>(
          listenWhen: (p, c) => p.setDefaultStatus != c.setDefaultStatus,
          listener: (context, s) => _toastOnChange(
            context,
            s,
            s.setDefaultStatus,
            l10n.addressesDefaultChanged,
          ),
        ),
        BlocListener<AddressCubit, AddressState>(
          listenWhen: (p, c) => p.deleteStatus != c.deleteStatus,
          listener: (context, s) =>
              _toastOnChange(context, s, s.deleteStatus, l10n.addressesDeleted),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<AddressCubit, AddressState>(
              buildWhen: (p, c) =>
              p.status != c.status ||
                  p.addresses != c.addresses ||
                  p.setDefaultStatus != c.setDefaultStatus ||
                  p.deleteStatus != c.deleteStatus,
              builder: (context, state) {
                final cubit = context.read<AddressCubit>();
                final isLoading = state.status == RequestStatus.loading ||
                    state.status == RequestStatus.initial;

                if (state.status == RequestStatus.failure &&
                    state.addresses.isEmpty) {
                  final message = state.failure?.localizedMessage(context);

                  return Center(
                    child: AppMessageWidget(
                      title: l10n.addressesLoadFailedTitle,
                      message: (message == null || message.isEmpty)
                          ? l10n.failureGeneric
                          : message,
                      actionLabel: l10n.addressesRetry,
                      onAction: cubit.fetchAddresses,
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
                          AddressCard(
                            address: Address.fake(isDefault: i == 0),
                            onEdit: () {},
                            onDelete: () {},
                            onSetDefault: () {},
                          ),
                          Dimens.gapMd,
                        ],
                      ],
                    ),
                  );
                }

                if (state.addresses.isEmpty) {
                  return const _EmptyAddresses();
                }

                return RefreshIndicator(
                  onRefresh: () => cubit.fetchAddresses(silent: true),
                  child: AppListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (final address in state.addresses) ...[
                        AddressCard(
                          address: address,
                          onEdit: () => _openForm(context, address: address),
                          onDelete: () => _confirmDelete(context, address),
                          onSetDefault: address.isDefault
                              ? null
                              : () => cubit.setAddressAsDefault(address.id),
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
              label: l10n.addressesAddNew,
              icon: Icons.add_rounded,
              onPressed: () => _openForm(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyAddresses extends StatelessWidget {
  const _EmptyAddresses();

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
                Icons.location_on_outlined,
                size: Dimens.iconLg,
                color: s.onPrimaryContainer,
              ),
            ),
            Dimens.gapLg,
            Text(l10n.addressesEmptyTitle, style: theme.textTheme.titleMedium),
            Dimens.gapXs,
            Text(
              l10n.addressesEmptyMessage,
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