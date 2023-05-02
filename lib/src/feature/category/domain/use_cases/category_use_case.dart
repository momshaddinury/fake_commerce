import 'package:dartz/dartz.dart';
import 'package:fake_commerce/src/feature/category/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryUseCaseProvider = Provider<CategoryUseCase>(
  (ref) => CategoryUseCase(
    ref.watch(categoryRepositoryProvider),
  ),
);

class CategoryUseCase {
  CategoryUseCase(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  Future<Either<Exception, List<String>>> categories() async {
    return await _categoryRepository.categories();
  }
}
