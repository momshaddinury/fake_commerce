import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/core/network/error_model.dart';
import 'package:fake_commerce/src/core/network/request_handler.dart';
import 'package:fake_commerce/src/feature/product/root/data/data_sources/product_data_source.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:fake_commerce/src/feature/product/root/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.dataSource});

  final ProductDataSource dataSource;

  @override
  Future<Either<ErrorModel, List<ProductModel>>> productList() async {
    return await dataSource.fetchProductList().guard(
          (data) => (data as List).map((e) {
            return ProductModel.fromJson(e);
          }).toList(),
        );
  }

  @override
  Future<Either<ErrorModel, ProductModel>> product(int id) async {
    return await dataSource
        .fetchProduct(id)
        .guard((data) => ProductModel.fromJson(data));
  }
}
