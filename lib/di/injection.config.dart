// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checkout/modules/cart/data/data_source/cart_local_data_source.dart'
    as _i342;
import 'package:checkout/modules/cart/data/repository/cart_repository_impl.dart'
    as _i841;
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart'
    as _i650;
import 'package:checkout/modules/cart/domain/use_case/add_product_cart_use_case.dart'
    as _i453;
import 'package:checkout/modules/cart/domain/use_case/delete_cart_item_use_case.dart'
    as _i684;
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart'
    as _i141;
import 'package:checkout/modules/cart/domain/use_case/get_cart_stream_use_case.dart'
    as _i978;
import 'package:checkout/modules/cart/domain/use_case/update_cart_item_quantity_use_case.dart'
    as _i428;
import 'package:checkout/modules/cart/presentation/bloc/cart_bloc.dart'
    as _i143;
import 'package:checkout/modules/cart/presentation/bloc/cart_button_bloc.dart'
    as _i624;
import 'package:checkout/modules/product/data/data_source/product_remote_data_source.dart'
    as _i108;
import 'package:checkout/modules/product/data/data_source/promotion_remote_data_source.dart'
    as _i718;
import 'package:checkout/modules/product/data/repository/product_repository_impl.dart'
    as _i129;
import 'package:checkout/modules/product/data/repository/promotion_repository_impl.dart'
    as _i492;
import 'package:checkout/modules/product/domain/repository/product_repository.dart'
    as _i199;
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart'
    as _i748;
import 'package:checkout/modules/product/domain/use_case/get_product_list_use_case.dart'
    as _i851;
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart'
    as _i694;
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart'
    as _i976;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i108.ProductRemoteDataSource>(
        () => _i108.ProductRemoteDataSourceImpl());
    gh.factory<_i718.PromotionRemoteDataSource>(
        () => _i718.PromotionRemoteDataSourceImpl());
    gh.factory<_i342.CartLocalDataSource>(
        () => _i342.CartLocalDataSourceImpl());
    gh.factory<_i199.ProductRepository>(
        () => _i129.ProductRepositoryImpl(gh<_i108.ProductRemoteDataSource>()));
    gh.factory<_i650.CartRepository>(
        () => _i841.CartRepositoryImpl(gh<_i342.CartLocalDataSource>()));
    gh.factory<_i453.AddProductCartUseCase>(
        () => _i453.AddProductCartUseCase(gh<_i650.CartRepository>()));
    gh.factory<_i978.GetCartStreamUseCase>(
        () => _i978.GetCartStreamUseCase(gh<_i650.CartRepository>()));
    gh.factory<_i684.DeleteCartItemUseCase>(
        () => _i684.DeleteCartItemUseCase(gh<_i650.CartRepository>()));
    gh.factory<_i428.UpdateCartItemQuantityUseCase>(
        () => _i428.UpdateCartItemQuantityUseCase(gh<_i650.CartRepository>()));
    gh.factory<_i624.CartButtonBloc>(
        () => _i624.CartButtonBloc(gh<_i978.GetCartStreamUseCase>()));
    gh.factory<_i694.ProductDetailBloc>(
        () => _i694.ProductDetailBloc(gh<_i453.AddProductCartUseCase>()));
    gh.factory<_i748.PromotionRepository>(() =>
        _i492.PromotionRepositoryImpl(gh<_i718.PromotionRemoteDataSource>()));
    gh.factory<_i851.GetProductListUseCase>(() => _i851.GetProductListUseCase(
          gh<_i199.ProductRepository>(),
          gh<_i748.PromotionRepository>(),
        ));
    gh.factory<_i141.GetCartDetailUseCase>(
        () => _i141.GetCartDetailUseCase(gh<_i748.PromotionRepository>()));
    gh.factory<_i976.ProductListBloc>(
        () => _i976.ProductListBloc(gh<_i851.GetProductListUseCase>()));
    gh.factory<_i143.CartBloc>(() => _i143.CartBloc(
          gh<_i978.GetCartStreamUseCase>(),
          gh<_i141.GetCartDetailUseCase>(),
          gh<_i428.UpdateCartItemQuantityUseCase>(),
          gh<_i684.DeleteCartItemUseCase>(),
        ));
    return this;
  }
}
