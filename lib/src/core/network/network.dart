import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

final dioProvider = Provider(
  (ref) {
    return RestClient(
      baseUrl: 'https://fakestoreapi.com/',
      token: '',
    );
  },
);
