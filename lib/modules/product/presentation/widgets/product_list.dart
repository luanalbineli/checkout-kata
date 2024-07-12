import 'package:auto_route/auto_route.dart';
import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/modules/product/domain/entity/product.dart';
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_price.dart';
import 'package:checkout/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
      if (state is ProductListStateSuccess) {
        return _buildProductList(context, state);
      }

      // TODO: Handle error and loading states.
      return const SizedBox.shrink();
    });
  }

  Widget _buildProductList(
    BuildContext context,
    ProductListStateSuccess state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products (${state.list.length}):',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppDimens.defaultMargin,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppDimens.defaultMargin,
                crossAxisSpacing: AppDimens.defaultMargin,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final product = state.list[index];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () => _openProductDetail(context, product),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.defaultMargin05x),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ProductImage(
                              imageUrl: product.imageUrl,
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.defaultMargin05x,
                          ),
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              ProductPrice(price: product.price),
                              const Spacer(),
                              const Icon(
                                Icons.add,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openProductDetail(BuildContext context, Product product) {
    context.router.push(ProductDetailRoute(product: product));
  }
}
