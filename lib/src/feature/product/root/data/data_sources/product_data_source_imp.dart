import 'package:dio/dio.dart';

import 'product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl({
    required this.client,
  });

  final Dio client;

  @override
  Future<Response> fetchProductList() async {
    return await client.get(
      'https://fakestoreapi.com/products',
    );
  }

  @override
  Future<Response> fetchProduct(int id) async {
    return await client.get(
      'https://fakestoreapi.com/products/$id',
    );
  }
}
