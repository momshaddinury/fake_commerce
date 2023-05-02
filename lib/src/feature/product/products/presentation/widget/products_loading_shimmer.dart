import 'package:flutter/material.dart';

class ProductsLoadingShimmer extends StatelessWidget {
  const ProductsLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.grey[200],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 100,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20,
                      width: 200,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20,
                      width: 100,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 8);
      },
    );
  }
}
