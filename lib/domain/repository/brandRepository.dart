import 'package:ecommerce/domain/model/Brand.dart';

abstract class brandRepository {
  Future<List<Brand>> getBrand();
}