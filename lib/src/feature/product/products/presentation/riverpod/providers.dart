import 'package:fake_commerce/src/core/state/base_state.dart';
import 'package:fake_commerce/src/feature/product/products/domain/entities/product_entity.dart';
import 'package:fake_commerce/src/feature/product/products/domain/use_cases/products_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'products_notifier.dart';

enum SortedMethod {
  asc,
  desc,
}

final sortingMethodProvider = StateProvider<bool>((ref) => false);
final selectedRangeProvider = StateProvider<String?>((ref) => null);
final productsProvider = StateNotifierProvider<ProductsNotifier, BaseState>(
  (ref) {
    return ProductsNotifier(
      ref: ref,
      useCase: ref.watch(productsUseCaseProvider),
    );
  },
);

final productDataProvider = Provider<ProductEntity>(
  (ref) => throw UnimplementedError(),
);
