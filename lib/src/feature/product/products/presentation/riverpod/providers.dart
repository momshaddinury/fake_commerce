import 'package:fake_commerce/src/core/state/base_state.dart';
import 'package:fake_commerce/src/feature/product/products/domain/use_cases/products_use_case.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'products_notifier.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, BaseState>(
  (ref) {
    return ProductsNotifier(
      ref: ref,
      useCase: ref.watch(productsUseCaseProvider),
    );
  },
);

final productDataProvider = Provider<ProductModel>(
  (ref) => throw UnimplementedError(),
);
