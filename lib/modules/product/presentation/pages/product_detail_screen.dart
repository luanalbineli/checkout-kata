import 'package:auto_route/auto_route.dart';
import 'package:checkout/di/injection.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<ProductDetailBloc>()
      ..add(
        ProductDetailEventUpdateQuantity(product, 1),
      );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: BlocProvider<ProductDetailBloc>(
        create: (_) => bloc,
        child: BlocListener<ProductDetailBloc, ProductDetailState>(
          bloc: bloc,
          listener: _handleStateChanges,
          child: ProductDetail(
            product: product,
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(
    BuildContext context,
    ProductDetailState state,
  ) {
    if (state is ProductDetailStateItemCartAdded) {
      const snackBar = SnackBar(content: Text('Item added to cart'));
      context.messenger.showSnackBar(snackBar);
      context.router.maybePop();
    } else if (state is ProductDetailStateItemCartError) {
      const snackBar = SnackBar(
        content: Text('We couldn\'t add the item now. Please, try again'),
      );
      context.messenger.showSnackBar(snackBar);
    }
  }
}
