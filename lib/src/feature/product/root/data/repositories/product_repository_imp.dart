import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/feature/product/root/data/data_sources/product_data_source.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.dataSource,
  });

  final ProductDataSource dataSource;

  @override
  Future<Either<Exception, List<ProductModel>>> productList() async {
    try {
      final response = await dataSource.fetchProductList();
      List<ProductModel> products = (response.data as List).map((e) {
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
  Future<Either<Exception, ProductModel>> product(int id) async {
    try {
      final response = await dataSource.fetchProduct(id);
      ProductModel product = ProductModel.fromJson(response.data);
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
