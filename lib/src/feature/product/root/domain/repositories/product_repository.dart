import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/core/network/error_model.dart';
import 'package:fake_commerce/src/feature/product/root/data/data_sources/product_data_source.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/data/repositories/product_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider(
  (ref) {
    return ProductRepositoryImpl(
      dataSource: ref.read(productDataSourceProvider),
    );
  },
);

abstract class ProductRepository {
  Future<Either<ErrorModel, List<ProductModel>>> productList();

  Future<Either<ErrorModel, ProductModel>> product(int id);
}
