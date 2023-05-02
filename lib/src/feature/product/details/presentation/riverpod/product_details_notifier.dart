import 'dart:developer';

import 'package:fake_commerce/src/feature/product/details/domain/use_cases/product_details_use_case.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailsProvider =
    FutureProvider.autoDispose.family<ProductModel?, int>(
  (ref, value) async {
    try {
      final result =
          await ref.read(productDetailsUseCaseProvider).product(value);
      return result.fold(
        (l) => null,
        (r) {
          ref.keepAlive();
          return r;
        },
      );
    } catch (e, stackTrace) {
      log(
        'productDetailsProvider.futureProvider',
        error: e,
        stackTrace: stackTrace,
      );
    }

    return null;
  },
);
