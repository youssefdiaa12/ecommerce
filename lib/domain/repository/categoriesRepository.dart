import 'package:ecommerce/domain/model/Category.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories();
}