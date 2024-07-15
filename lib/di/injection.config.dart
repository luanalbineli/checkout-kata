// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checkout/modules/cart/data/data_source/cart_local_data_source.dart'
    as _i5;
import 'package:checkout/modules/cart/data/repository/cart_repository_impl.dart'
    as _i9;
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart'
    as _i8;
import 'package:checkout/modules/cart/domain/use_case/add_product_cart_use_case.dart'
    as _i10;
import 'package:checkout/modules/cart/domain/use_case/get_cart_detail_use_case.dart'
    as _i18;
import 'package:checkout/modules/cart/domain/use_case/get_cart_stream_use_case.dart'
    as _i11;
import 'package:checkout/modules/cart/presentation/bloc/cart_bloc.dart' as _i19;
import 'package:checkout/modules/cart/presentation/bloc/cart_button_bloc.dart'
    as _i12;
import 'package:checkout/modules/product/data/data_source/product_remote_data_source.dart'
    as _i3;
import 'package:checkout/modules/product/data/data_source/promotion_remote_data_source.dart'
    as _i4;
import 'package:checkout/modules/product/data/repository/product_repository_impl.dart'
    as _i7;
import 'package:checkout/modules/product/data/repository/promotion_repository_impl.dart'
    as _i15;
import 'package:checkout/modules/product/domain/repository/product_repository.dart'
    as _i6;
import 'package:checkout/modules/product/domain/repository/promotion_repository.dart'
    as _i14;
import 'package:checkout/modules/product/domain/use_case/get_product_list_use_case.dart'
    as _i16;
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart'
    as _i13;
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart'
    as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ProductRemoteDataSource>(
        () => _i3.ProductRemoteDataSourceImpl());
    gh.factory<_i4.PromotionRemoteDataSource>(
        () => _i4.PromotionRemoteDataSourceImpl());
    gh.singleton<_i5.CartLocalDataSource>(() => _i5.CartLocalDataSourceImpl());
    gh.factory<_i6.ProductRepository>(
        () => _i7.ProductRepositoryImpl(gh<_i3.ProductRemoteDataSource>()));
    gh.factory<_i8.CartRepository>(
        () => _i9.CartRepositoryImpl(gh<_i5.CartLocalDataSource>()));
    gh.factory<_i10.AddProductCartUseCase>(
        () => _i10.AddProductCartUseCase(gh<_i8.CartRepository>()));
    gh.factory<_i11.GetCartStreamUseCase>(
        () => _i11.GetCartStreamUseCase(gh<_i8.CartRepository>()));
    gh.factory<_i12.CartButtonBloc>(
        () => _i12.CartButtonBloc(gh<_i11.GetCartStreamUseCase>()));
    gh.factory<_i13.ProductDetailBloc>(
        () => _i13.ProductDetailBloc(gh<_i10.AddProductCartUseCase>()));
    gh.factory<_i14.PromotionRepository>(() =>
        _i15.PromotionRepositoryImpl(gh<_i4.PromotionRemoteDataSource>()));
    gh.factory<_i16.GetProductListUseCase>(
        () => _i16.GetProductListUseCase(gh<_i6.ProductRepository>()));
    gh.factory<_i17.ProductListBloc>(
        () => _i17.ProductListBloc(gh<_i16.GetProductListUseCase>()));
    gh.factory<_i18.GetCartDetailUseCase>(
        () => _i18.GetCartDetailUseCase(gh<_i14.PromotionRepository>()));
    gh.factory<_i19.CartBloc>(() => _i19.CartBloc(
          gh<_i11.GetCartStreamUseCase>(),
          gh<_i18.GetCartDetailUseCase>(),
        ));
    return this;
  }
}
