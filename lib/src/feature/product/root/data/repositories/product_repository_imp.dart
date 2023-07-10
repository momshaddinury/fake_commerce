import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/feature/product/products/domain/entities/product_entity.dart';
import 'package:fake_commerce/src/feature/product/root/data/data_sources/product_data_source.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.dataSource,
  });

  final ProductDataSource dataSource;

  @override
  Future<Either<Exception, List<ProductEntity>>> productList(
    String? sortingMethod,
    String? limit,
  ) async {
    try {
      final response = await dataSource.fetchProductList(
        sortingMethod,
        limit,
      );
      List<ProductEntity> products = (response.data as List).map((e) {
        return ProductModel.fromJson(e);
      }).toList();

      return Right(products);
    } catch (e, stackTrace) {
      log(
        'ProductRepositoryImpl.productList',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, ProductEntity>> product(int id) async {
    try {
      final response = await dataSource.fetchProduct(id);
      ProductEntity product = ProductModel.fromJson(response.data);
      // throw Exception('test');
      return Right(product);
    } catch (e, stackTrace) {
      log(
        'ProductRepositoryImpl.product',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(Exception(e));
    }
  }
}
