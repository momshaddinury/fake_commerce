import 'package:fake_commerce/src/feature/product/details/presentation/riverpod/product_details_notifier.dart';
import 'package:fake_commerce/src/feature/product/details/presentation/widgets/product_details_loading_shimmer.dart';
import 'package:fake_commerce/src/feature/product/root/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../widgets/product_details_builder.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: state.when(
        data: (product) {
          return _ProductDetailsBuilder(product: product!);
        },
        loading: () => const ProductDetailsLoadingShimmer(),
        error: (error, stackTrace) {
          return const Center(child: Text('Error'));
        },
      ),
    );
  }
}
