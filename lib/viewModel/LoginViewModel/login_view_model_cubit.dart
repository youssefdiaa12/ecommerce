import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/useCase/loginUseCase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/model/User/User.dart';

part 'login_view_model_state.dart';
@injectable
class LoginViewModelCubit extends Cubit<LoginViewModelState> {
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 loginUseCase LoginUseCase;
 @factoryMethod LoginViewModelCubit(this.LoginUseCase) : super(LoginViewModelInitial());
 void login()async {
  //call use case register
  var User1;
  try {
   emit(LoginViewModelLoading());
   User1=await LoginUseCase.invoke(
       emailController.text,
       passwordController.text,);
   print(User1);
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
