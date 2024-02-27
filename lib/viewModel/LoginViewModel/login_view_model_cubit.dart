import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/useCase/loginUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../data/model/User/UseDaoFireBase.dart';
import '../../data/model/User/User.dart';
import '../../di/di.dart';
import '../ProivderViewModel/app_provider.dart';
part 'login_view_model_state.dart';
@injectable
class LoginViewModelCubit extends Cubit<LoginViewModelState> {
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 loginUseCase LoginUseCase;
 @factoryMethod LoginViewModelCubit(this.LoginUseCase) : super(LoginViewModelInitial());
 void login()async {
  //call use case register
  try{
   emit(LoginViewModelLoading());
   final response =await FirebaseAuth.instance.signInWithEmailAndPassword(email:emailController.text,
       password: passwordController.text);
   AppProvider.user_fire_base =await UserDaoFireBase.getuser(response.user?.uid);
  }
  on FirebaseAuthException catch(e){
   emit(LoginViewModelError(e.toString()));
   return;
  }
  User_api? User1;
  try {
  User1=await LoginUseCase.invoke(
       emailController.text,
       passwordController.text,);
   if(User1==null||User1?.email==null){
    emit(LoginViewModelError("Invalid email or password"));
    return;
   }
   User1?.email=emailController.text;
   User1?.pass=passwordController.text;
   User1?.phone=AppProvider.user_fire_base?.phone??"";
   User1?.address=AppProvider.user_fire_base?.address??"";
  // var provider1 = getIt<AppProvider>();
  // // await provider1.loggedin()?await provider1.getProductList(AppProvider.user?.token??""):null;
  // // await provider1.loggedin()?await provider1.getCartList(AppProvider.user?.token??""):null;

   emit(LoginViewModelSuccess(User1));
  }
  catch(e) {
   if (User1 == null) {
    emit(LoginViewModelError("Invalid email or password"));
   }
   else{
    emit(LoginViewModelError(e.toString()));
   }
  }
 }

}
