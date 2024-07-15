import 'package:checkout/constants/app_constants.dart';
import 'package:checkout/modules/product/data/model/product_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getList();
}

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getList() => Future.delayed(
        AppConstants.queryDuration,
        () => _productList,
      );

  static const _productList = [
    ProductModel(
      sku: 'A',
      name: 'Apple',
      imageUrl:
          'https://assets.clevelandclinic.org/transform/cd71f4bd-81d4-45d8-a450-74df78e4477a/Apples-184940975-770x533-1_jpg',
      price: .5,
    ),
    ProductModel(
      sku: 'B',
      name: 'Bread',
      imageUrl:
          'https://steamandbake.com/wp-content/uploads/2023/10/NEW-Steam-Oven-Bread-process-3-1.jpg',
      price: .75,
    ),
    ProductModel(
      sku: 'C',
      name: 'Carrot with a big description',
      imageUrl:
          'https://blog-images-1.pharmeasy.in/blog/production/wp-content/uploads/2021/04/23175719/shutterstock_440493100-1.jpg',
      price: .25,
    ),
    ProductModel(
      sku: 'D',
      name: 'Diet Coke',
      price: 1.5,
      imageUrl: null,
    ),
    ProductModel(
      sku: 'E',
      name: 'Egg Salad',
      imageUrl:
          'https://www.egginfo.co.uk/sites/default/files/styles/amp_1200x1200_1_1/public/2021/05/Mediterranean%20egg%20salad.jpg?h=7c51c08c&itok=R1PCjRs7',
      price: 2,
    ),
  ];
}
