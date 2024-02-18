import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Category.dart';
import 'package:ecommerce/domain/useCase/categoriesProductsUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/model/Product.dart';

part 'category_products_state.dart';

@injectable
class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  categoriesProductsUseCase categoriesProductsUseCase1;
  Category? category;
  @factoryMethod CategoryProductsCubit(this.categoriesProductsUseCase1) : super(CategoryProductsInitial());

  void getData({Category ?category}) async {
    this.category=category;
    emit(CategoryProductsLoading());
    try {
      List<Product> products = await categoriesProductsUseCase1.invoke(0, 40,category: category);

      emit(CategoryProductsSuccessful(products));
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }

}
