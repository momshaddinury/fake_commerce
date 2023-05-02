import 'package:flutter/material.dart';

class ProductDetailsLoadingShimmer extends StatelessWidget {
  const ProductDetailsLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[200],
          ),
          const Divider(),
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
  }
}
