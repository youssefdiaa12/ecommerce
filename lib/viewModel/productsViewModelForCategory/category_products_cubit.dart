import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Category.dart';
import 'package:ecommerce/domain/useCase/categoriesProductsUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../di/di.dart';
import '../../domain/model/Product.dart';
import '../ProivderViewModel/app_provider.dart';

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
      List<Product> products = await categoriesProductsUseCase1.invoke(0, 60,category: category);

      emit(CategoryProductsSuccessful(products));
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }
  Future<bool> checkAuthority()async{
    var provider1 = getIt<AppProvider>();
    bool is_logged =await provider1.loggedin();
    if(!is_logged){
      emit(unAuthorized1());
      return false;
    }
    else{
      return true;
    }
  }


}
