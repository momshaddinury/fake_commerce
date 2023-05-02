import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsUseCaseProvider = Provider(
  (ref) {
    return ProductsUseCase(
      ref.read(productRepositoryProvider),
    );
  },
);

class ProductsUseCase {
  ProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Exception, List<ProductModel>>> productList() async {
    return await _repository.productList();
  }
}
