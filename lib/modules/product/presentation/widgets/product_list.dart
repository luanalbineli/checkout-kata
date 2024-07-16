import 'package:auto_route/auto_route.dart';
import 'package:checkout/constants/app_dimens.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:checkout/extensions/text_theme_extensions.dart';
import 'package:checkout/modules/core/presentation/widgets/error_state.dart';
import 'package:checkout/modules/core/presentation/widgets/margin.dart';
import 'package:checkout/modules/product/domain/entity/product_display.dart';
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart';
import 'package:checkout/modules/product/presentation/widgets/product_image.dart';
import 'package:checkout/modules/product/presentation/widgets/product_loading.dart';
import 'package:checkout/modules/product/presentation/widgets/product_name.dart';
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

      if (state is ProductListStateError) {
        const ErrorState();
      }

      return const ProductLoading();
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
            style: context.textTheme.screenTitle,
          ),
          const VerticalMargin(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppDimens.defaultMargin,
                crossAxisSpacing: AppDimens.defaultMargin,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final productDisplay = state.list[index];
                final ProductDisplay(:product) = productDisplay;

                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () => _openProductDetail(context, productDisplay),
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
                          const VerticalMargin(
                            margin: AppDimens.defaultMargin05x,
                          ),
                          ProductName(
                            name: product.name,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              ProductPrice(price: product.price),
                              const Spacer(),
                              _buildAddProductIcon(context, productDisplay),
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

  void _openProductDetail(
    BuildContext context,
    ProductDisplay productDisplay,
  ) {
    context.router.push(ProductDetailRoute(productDisplay: productDisplay));
  }

  Widget _buildAddProductIcon(
      BuildContext context, ProductDisplay productDisplay) {
    const addIcon = Icon(
      Icons.add_rounded,
    );

    if (productDisplay.promotionDisplay == null) {
      return addIcon;
    }

    return Badge(
      backgroundColor: context.theme.primaryColor,
      offset: const Offset(-2, -2),
      label: const Icon(
        Icons.percent_outlined,
        size: 12,
        color: Colors.white,
      ),
      largeSize: 12,
      child: addIcon,
    );
  }
}
