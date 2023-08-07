import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/core/network/error_model.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailsUseCaseProvider = Provider<ProductDetailsUseCase>(
  (ref) {
    final repository = ref.watch(productRepositoryProvider);
    return ProductDetailsUseCase(repository);
  },
);

class ProductDetailsUseCase {
  ProductDetailsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<ErrorModel, ProductModel>> product(int id) async {
    return await _repository.product(id);
  }
}
