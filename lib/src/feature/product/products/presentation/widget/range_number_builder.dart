import 'package:fake_commerce/src/feature/product/products/presentation/riverpod/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RangeNumberBuilder extends ConsumerStatefulWidget {
  const RangeNumberBuilder({super.key});

  @override
  ConsumerState<RangeNumberBuilder> createState() => _SortingBuilderState();
}

class _SortingBuilderState extends ConsumerState<RangeNumberBuilder> {
  String? _radioValue = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text('All'),
                value: 'All',
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
    );
  }

  void radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'All':
          ref.read(selectedRangeProvider.notifier).state = null;
          break;
        case '1-5':
          ref.read(selectedRangeProvider.notifier).state = '5';
          break;
        case '1-10':
          ref.read(selectedRangeProvider.notifier).state = '10';
          break;
        case '1-15':
          ref.read(selectedRangeProvider.notifier).state = '15';
          break;
        default:
          ref.read(selectedRangeProvider.notifier).state = null;
      }
    });
    ref.read(productsProvider.notifier).productList(
          sortingMethod: ref.watch(sortingMethodProvider.notifier).state
              ? SortedMethod.desc.name
              : SortedMethod.asc.name,
          limit: ref.watch(selectedRangeProvider.notifier).state,
        );
  }
}
