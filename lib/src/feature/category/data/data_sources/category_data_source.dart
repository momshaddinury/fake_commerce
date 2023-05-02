import 'package:dio/dio.dart';
import 'package:fake_commerce/src/core/network/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category_data_source_imp.dart';

final categoryDataSourceProvider = Provider<CategoryDataSource>(
  (ref) => CategoryDataSourceImpl(
    client: ref.watch(dioProvider),
  ),
);

abstract class CategoryDataSource {
  Future<Response> categories();
}
