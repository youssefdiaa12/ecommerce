import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Category.dart';
import 'package:ecommerce/domain/useCase/MostSellingProductsUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/User/UseDaoFireBase.dart';
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
      var  firebaseauth = FirebaseAuth.instance.currentUser;
      if (firebaseauth != null) {
        AppProvider.user_fire_base = await UserDaoFireBase.getuser(firebaseauth.uid);
      }
      categories = await categoriesUseCase1.invoke();
       brands = await brandsUseCase1.invoke();
       products = await productsUseCase1.invoke(pageNo, Limit);
      var provider1 = getIt<AppProvider>();
      bool isLogged=FirebaseAuth.instance.currentUser!=null;
      if(isLogged){
       await provider1.getProductList(AppProvider.user?.token??"");
        await provider1.getCartList(AppProvider.user?.token??"");
       emit(HomeTapViewModelSuccessful(categories, brands, products));
      }
      else{
    provider1.products_cartList=[];
    provider1.product_cartList_count={};
    provider1.products_wishList=[];
    emit(HomeTapViewModelSuccessful(categories, brands, products));
      }
    }
    catch(e){
      emit(HomeTapViewModelError(e.toString()));
    }
  }
  Future<bool> checkAuthority()async{
    var provider1 = getIt<AppProvider>();
    bool isLogged =await provider1.loggedin();
    if(!isLogged){
      emit(unAuthorized());
      return false;
    }
    else{
      return true;
    }
  }


}
