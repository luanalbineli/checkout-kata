// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checkout/modules/product/data/data_source/product_remote_data_source.dart'
    as _i3;
import 'package:checkout/modules/product/data/repository/product_repository_impl.dart'
    as _i5;
import 'package:checkout/modules/product/domain/repository/product_repository.dart'
    as _i4;
import 'package:checkout/modules/product/domain/use_case/get_product_list_use_case.dart'
    as _i6;
import 'package:checkout/modules/product/presentation/bloc/product_list_bloc.dart'
    as _i7;
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
    gh.factory<_i4.ProductRepository>(
        () => _i5.ProductRepositoryImpl(gh<_i3.ProductRemoteDataSource>()));
    gh.factory<_i6.GetProductListUseCase>(
        () => _i6.GetProductListUseCase(gh<_i4.ProductRepository>()));
    gh.factory<_i7.ProductListBloc>(
        () => _i7.ProductListBloc(gh<_i6.GetProductListUseCase>()));
    return this;
  }
}
