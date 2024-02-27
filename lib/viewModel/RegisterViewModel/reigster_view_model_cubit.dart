import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/model/User/User.dart';
import 'package:ecommerce/domain/useCase/registerationUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../data/model/User/FireBaseUser.dart';
import '../../data/model/User/UseDaoFireBase.dart';
import '../ProivderViewModel/app_provider.dart';

part 'reigster_view_model_state.dart';
@injectable
class ReigsterViewModelCubit extends Cubit<ReigsterViewModelState> {
 TextEditingController userName = TextEditingController();
 TextEditingController phoneNumber = TextEditingController();
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 TextEditingController confirmPasswordController = TextEditingController();
registerationUseCase registerationUseCase1;
 @factoryMethod ReigsterViewModelCubit(this.registerationUseCase1) : super(ReigsterViewModelInitial());
 void register()async {
  //call use case register
  try{
   emit(ReigsterViewModelLoading());
  final response= await FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailController.text, password: passwordController.text);
   await UserDaoFireBase.createuser(FireBaseUser(
       userName.text,
       emailController.text,
       phoneNumber.text,
   "",
   response.user?.uid,
   ));
   AppProvider.user_fire_base=await UserDaoFireBase.getuser(response.user?.uid);
  }
 on FirebaseAuthException catch(e){
   emit(ReigsterViewModelError(e.toString()));
   return;
 }
  try {
   var User1 =await registerationUseCase1.invoke(
       userName.text,
       emailController.text,
       passwordController.text,
       confirmPasswordController.text,
       phoneNumber.text);
   emit(ReigsterViewModelSuccess(User1 as User_api));
  }
  catch(e){
   emit(ReigsterViewModelError("Account already exists"));
  }
 }

}
