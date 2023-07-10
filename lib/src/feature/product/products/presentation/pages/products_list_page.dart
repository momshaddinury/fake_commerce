import 'dart:developer';

import 'package:fake_commerce/src/core/router/routers.dart';
import 'package:fake_commerce/src/core/state/base_state.dart';
import 'package:fake_commerce/src/feature/category/presentation/provider/category_list_provider.dart';
import 'package:fake_commerce/src/feature/category/presentation/widgets/category_loading_shimmer.dart';
import 'package:fake_commerce/src/feature/product/products/domain/entities/product_entity.dart';
import 'package:fake_commerce/src/feature/product/products/presentation/riverpod/providers.dart';
import 'package:fake_commerce/src/feature/product/products/presentation/widget/products_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part '../widget/category_builder.dart';
part '../widget/product_card.dart';
part '../widget/product_list_builder.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  int? _groupValue;
  String? _radioValue; //Initial definition of radio button value
  String? choice;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(productsProvider.notifier)
          .productList(sortingMethod: SortedMethod.asc.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsProvider);
    final categoriesState = ref.watch(categoriesProvider);
    ref.watch(sortingMethodProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              sortedProducts();
            },
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('All'),
                      value: '',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('1-5'),
                      value: '1-5',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('1-10'),
                      value: '1-10',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('1-15'),
                      value: '1-15',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                  ),
                ],
              )
            ],
          ),

          /// Categories
          categoriesState.when(
            data: (categories) {
              return _CategoryBuilder(categories: categories);
            },
            loading: () => const CategoryLoadingShimmer(),
            error: (error, stackTrace) {
              log(
                "ProductListPage.categoriesState.when",
                error: error.toString(),
                stackTrace: stackTrace,
              );
              return const Center(child: Text('Error'));
            },
          ),

          /// Product List
          state is LoadingState
              ? const Expanded(child: ProductsLoadingShimmer())
              : state is SuccessState<List<ProductEntity>>
                  ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(selectedCategoryProvider);
                          await ref
                              .read(productsProvider.notifier)
                              .productList();
                        },
                        child: _ProductListBuilder(products: state.data!),
                      ),
                    )
                  : const Center(child: Text('Error')),
        ],
      ),
    );
  }

  void radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'All':
          choice = null;
          break;
        case '1-5':
          choice = '5';
          break;
        case '1-10':
          choice = '10';
          break;
        case '1-15':
          choice = '15';
          break;
        default:
          choice = null;
      }

      debugPrint(choice); //Debug the choice in console
    });
    ref.read(productsProvider.notifier).productList(
        sortingMethod: ref.read(sortingMethodProvider.notifier).state
            ? SortedMethod.desc.name
            : SortedMethod.asc.name,
        limit: choice);
  }

  void sortedProducts() async {
    ref.read(sortingMethodProvider.notifier).state =
        !ref.read(sortingMethodProvider.notifier).state;
    ref.read(productsProvider.notifier).productList(
          sortingMethod: ref.read(sortingMethodProvider.notifier).state
              ? SortedMethod.desc.name
              : SortedMethod.asc.name,
          limit: choice,
        );
  }
}
