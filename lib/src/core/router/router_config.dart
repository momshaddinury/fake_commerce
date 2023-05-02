import 'package:fake_commerce/src/core/router/routers.dart';
import 'package:fake_commerce/src/feature/product/details/presentation/pages/product_details_page.dart';
import 'package:fake_commerce/src/feature/product/products/presentation/pages/products_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) => _router);

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: Routes.productList.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ProductListPage(),
        );
      },
      routes: [
        GoRoute(
          path: Routes.productList.name,
          name: Routes.productDetails.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: ProductDetailsPage(
                productId: int.parse(state.queryParameters['id']!),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
