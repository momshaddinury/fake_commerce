import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl({
    required this.client,
  });

  final Dio client;
  var logger = Logger();
  @override
  Future<Response> fetchProductList(
    String? sortingMethod,
    String? limit,
  ) async {
    Response res = await client.get(
      'https://fakestoreapi.com/products',
      queryParameters: {
        'sort': sortingMethod,
        'limit': limit,
      },
    );
    logger.d(res.data);
    return res;
  }

  @override
  Future<Response> fetchProduct(int id) async {
    return await client.get(
      'https://fakestoreapi.com/products/$id',
    );
  }
}
