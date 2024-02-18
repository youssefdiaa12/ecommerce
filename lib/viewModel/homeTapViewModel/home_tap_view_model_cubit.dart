import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Category.dart';
import 'package:ecommerce/domain/useCase/MostSellingProductsUseCase.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../di/di.dart';
import '../../domain/model/Brand.dart';
import '../../domain/model/Product.dart';
import '../../domain/useCase/brandsUseCase.dart';
import '../../domain/useCase/categoriesUseCase.dart';
import '../ProivderViewModel/app_provider.dart';

part 'home_tap_view_model_state.dart';
@injectable
class HomeTapViewModelCubit extends Cubit<HomeTapViewModelState> {
  categoriesUseCase categoriesUseCase1;
  brandsUseCase brandsUseCase1;
  MostSellingProductsUseCase productsUseCase1;
List<Category> categories=[];
List<Brand> brands=[];
List<Product> products=[];
  HomeTapViewModelCubit(this.categoriesUseCase1,this.brandsUseCase1,this.productsUseCase1) : super(HomeTapViewModelInitial());

  Future<void> getData(int pageNo,int Limit)async {
    emit(HomeTapViewModelLoading());
    try {
      print("HomeTapViewModelLoading");
      categories = await categoriesUseCase1.invoke();
      print("categories");
       brands = await brandsUseCase1.invoke();
       print("brands");
       products = await productsUseCase1.invoke(pageNo, Limit);
       print("products");
      emit(HomeTapViewModelSuccessful(categories, brands, products));
    }
    catch(e){
      print(e);
      emit(HomeTapViewModelError(e.toString()));
    }
  }
  Future<bool> checkAuthority()async{
    var provider1 = getIt<AppProvider>();
    bool is_logged =await provider1.loggedin();
    if(!is_logged){
      emit(unAuthorized());
      return false;
    }
    else{
      return true;
    }
  }


}
