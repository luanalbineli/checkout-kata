// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checkout/modules/cart/data/data_source/cart_local_data_source.dart'
    as _i4;
import 'package:checkout/modules/cart/data/repository/cart_repository_impl.dart'
    as _i8;
import 'package:checkout/modules/cart/domain/repository/cart_repository.dart'
    as _i7;
import 'package:checkout/modules/cart/domain/use_case/add_product_cart_use_case.dart'
    as _i9;
import 'package:checkout/modules/product/data/data_source/product_remote_data_source.dart'
    as _i3;
import 'package:checkout/modules/product/data/repository/product_repository_impl.dart'
    as _i6;
import 'package:checkout/modules/product/domain/repository/product_repository.dart'
    as _i5;
import 'package:checkout/modules/product/domain/use_case/get_product_list_use_case.dart'
    as _i11;
import 'package:checkout/modules/product/presentation/bloc/product_detail_bloc.dart'
    as _i10;
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart'
    as _i12;
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
    gh.factory<_i4.CartLocalDataSource>(() => _i4.CartLocalDataSourceImpl());
    gh.factory<_i5.ProductRepository>(
        () => _i6.ProductRepositoryImpl(gh<_i3.ProductRemoteDataSource>()));
    gh.factory<_i7.CartRepository>(
        () => _i8.CartRepositoryImpl(gh<_i4.CartLocalDataSource>()));
    gh.factory<_i9.AddProductCartUseCase>(
        () => _i9.AddProductCartUseCase(gh<_i7.CartRepository>()));
    gh.factory<_i10.ProductDetailBloc>(
        () => _i10.ProductDetailBloc(gh<_i9.AddProductCartUseCase>()));
    gh.factory<_i11.GetProductListUseCase>(
        () => _i11.GetProductListUseCase(gh<_i5.ProductRepository>()));
    gh.factory<_i12.ProductListBloc>(
        () => _i12.ProductListBloc(gh<_i11.GetProductListUseCase>()));
    return this;
  }
}
