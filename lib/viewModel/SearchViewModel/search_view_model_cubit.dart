import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../di/di.dart';
import '../../domain/useCase/getAllProductsUseCase.dart';

part 'search_view_model_state.dart';
@injectable
class SearchViewModelCubit extends Cubit<SearchViewModelState> {
  getAllProductsUseCase getAllProductsUseCase1;
 @factoryMethod SearchViewModelCubit(this.getAllProductsUseCase1) : super(SearchViewModelInitial());

  Future<bool> checkUser() async {
    var provider1 = getIt<AppProvider>();
    bool is_logged = await provider1.loggedin();
    if (is_logged) {
      return true;
    } else {
      emit(UnAuthenticatedTapState());
      return false;
    }
  }

  Future<void> invoke(int pageNo,int Limit,String search)async{
    emit(SearchViewModelLoading());
    try {
      List<Product> obj = await getAllProductsUseCase1.invoke(pageNo, Limit);
      List<Product> obj1=[];
      if(search==""){
        emit(SearchViewModelEmpty());
        return;
      }
      for(var element in obj){
        String title = element.title!;
        title = title.toLowerCase();
        search = search.toLowerCase();
        if(title.contains(search)&&search!=""){
          obj1.add(element);
        }
      }
      emit(SearchViewModelSuccess(obj1));
    }
    catch(e){
      emit(SearchViewModelError());
    }
  }


}
