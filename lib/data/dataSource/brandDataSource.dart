import 'package:ecommerce/domain/model/Brand.dart';

import '../../domain/model/Category.dart';

abstract class brandDataSource {
  Future<List<Brand>> getBrands();
}