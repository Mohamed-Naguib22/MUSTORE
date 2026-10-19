import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/catalog/domain/use_cases/category/get_root_categories_use_case.dart';
import 'package:mustore/features/catalog/presentation/controllers/category/category_state.dart';

class CategoryCubit extends Cubit<CategoryState>
    with SafeEmitMixin<CategoryState> {
  CategoryCubit(this._getRootCategories) : super(const CategoryState());

  final GetRootCategoriesUseCase _getRootCategories;

  Future<void> fetchRootCategories() async {
    if (state.status.isLoading) return;

    safeEmit(state.copyWith(status: RequestStatus.loading, clearFailure: true));

    final result = await _getRootCategories(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (categories) => state.copyWith(
        status: RequestStatus.success,
        rootCategories: categories,
        clearFailure: true,
      ),
    );
  }
}