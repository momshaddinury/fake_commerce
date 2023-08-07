import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/core/network/error_model.dart';
import 'package:fake_commerce/src/core/network/request_handler.dart';
import 'package:fake_commerce/src/feature/category/data/data_sources/category_data_source.dart';
import 'package:fake_commerce/src/feature/category/data/models/category_model.dart';
import 'package:fake_commerce/src/feature/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.dataSource,
  });

  final CategoryDataSource dataSource;

  @override
  Future<Either<ErrorModel, List<String>>> categories() async {
    return await dataSource.categories().guard((data) {
      return categoryModelFromJson(data);
    });
  }
}
