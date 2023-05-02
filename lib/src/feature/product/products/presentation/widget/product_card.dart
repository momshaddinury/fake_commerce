part of '../pages/products_list_page.dart';

class _ProductCard extends ConsumerWidget {
  const _ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ProductModel data = ref.read(productDataProvider);

    return ListTile(
      onTap: () {
        _navigateToProductDetailsPage(context, data.id);
      },
      leading: Image.network(
        data.image,
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
      title: Text(data.title),
      subtitle: Text("\$${data.price}"),
    );
  }

  void _navigateToProductDetailsPage(
    BuildContext context,
    int id,
  ) {
    context.goNamed(
      Routes.productDetails.name,
      queryParameters: <String, String>{
        'id': id.toString(),
      },
    );
  }
}
