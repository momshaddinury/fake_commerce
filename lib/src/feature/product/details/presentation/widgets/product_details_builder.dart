part of '../pages/product_details_page.dart';

class _ProductDetailsBuilder extends ConsumerWidget {
  const _ProductDetailsBuilder({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context, ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(productDetailsProvider(product.id).future),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 16),
          Image.network(
            product.image,
            fit: BoxFit.contain,
            width: double.infinity,
            height: 250,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "\$${product.price}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  "Category: ${product.category.toUpperCase()}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
