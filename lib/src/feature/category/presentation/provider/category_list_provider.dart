import 'dart:developer';

import 'package:fake_commerce/src/feature/category/domain/use_cases/category_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => '');

final categoriesProvider = FutureProvider<List<String>>(
  (ref) async {
    final categories = await ref.watch(categoryUseCaseProvider).categories();

    return categories.fold(
      (l) {
        log(
          'categoriesProvider',
          error: l,
        );
        return [];
      },
      (r) => r,
    );
  },
);
