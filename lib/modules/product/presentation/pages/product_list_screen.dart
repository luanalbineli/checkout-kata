import 'package:auto_route/annotations.dart';
import 'package:checkout/di/injection.dart';
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Kata'),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (_) => getIt<ProductListBloc>(),
        child: const ProductList(),
      ),
    );
  }
}
