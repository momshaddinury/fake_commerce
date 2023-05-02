part of '../pages/products_list_page.dart';

class _ProductListBuilder extends StatelessWidget {
  const _ProductListBuilder({
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        /// This might feel redundant to use a provider to pass
        /// data to class, when we can just use prop-drilling to
        /// pass the data.
        /// But, this is recommended way as you can declare the class
        /// as const, which will improve performance.

        return ProviderScope(
          overrides: [
            productDataProvider.overrideWithValue(
              products[index],
            ),
          ],
          child: const _ProductCard(),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
