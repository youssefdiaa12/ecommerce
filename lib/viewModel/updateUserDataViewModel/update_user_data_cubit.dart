import 'package:bloc/bloc.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/model/User/UseDaoFireBase.dart';
import '../../di/di.dart';
import '../../domain/useCase/updateUserDataUseCase.dart';



part 'update_user_data_state.dart';
@injectable
@singleton
class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  updateUserDataUseCase updateUserData1;
  TextEditingController nameController = TextEditingController();
  List<bool> is_changes = [false, false, false, false, false];

  // bool is_name_changed=false;
  // bool is_password_changed=false;
  // bool is_phone_changed=false;
  // bool is_address_changed=false;
  // bool is_email_changed=false;
  bool is_change = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @factoryMethod UpdateUserDataCubit(this.updateUserData1)
      : super(UpdateUserDataInitial());

  void intializeData() {
    if(AppProvider.user?.email==null){
      emit(unAuthorized());
      return;
    }
    nameController.text = AppProvider.user?.name ?? "";
    emailController.text = AppProvider.user?.email ?? "";
    phoneController.text = AppProvider.user?.phone ?? "";
    addressController.text = AppProvider.user?.address ?? "";
    passwordController.text = AppProvider.user?.pass ?? "";
    emit(UpdateUserDataSuccess());
  }

  bool is_user_data_changed() {
    if (emailController.text != AppProvider.user?.email ||
        nameController.text != AppProvider.user?.name ||
        phoneController.text != AppProvider.user?.phone ||
        addressController.text != AppProvider.user?.address) {
      print(emailController.text);
      print(nameController.text);
      print(phoneController.text);
      print(addressController.text);
      print(AppProvider.user?.email);
      print(AppProvider.user?.name);
      print(AppProvider.user?.phone);
      print(AppProvider.user?.address);
      print("data_changed");
      return true;
    }
    return false;
  }

  bool is_password_changed_check() {
    if (passwordController.text != AppProvider.user?.pass) {
      print("pass_changed");
      print(passwordController.text);
      print(AppProvider.user?.pass);
      return true;
    }
    return false;
  }

  bool is_changed_occur() {
    print("is_phonenumber_changed");
    print(is_changes[4]);
    print("is_email_changed");
    print(is_changes[1]);
    print("is_password_changed");
    print(is_changes[2]);
    print("is_address_changed");
    print(is_changes[4]);
    print("is_name_changed");
    print(is_changes[0]);
    return is_changes[0] || is_changes[1] || is_changes[2] || is_changes[3] ||
        is_changes[4];
  }


  Future<void> updateUserData(String name, String email, String phone,
      String token, String address) async {
    emit(UpdateUserDataLoading());
    String? response;
    try{
      print("sama");
      print(FirebaseAuth.instance.currentUser);
      print(AppProvider.user?.pass);
      if(FirebaseAuth.instance.currentUser!=null&&!FirebaseAuth.instance.currentUser!.emailVerified){
        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        emit(verfiyUser());
        return;
      }
      // final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email:"youssefdiaa2222@icloud.com"??"",
      //     password:  AppProvider.user?.pass ?? "");
      // var message = "error";
      // final user = userCredential.user;
      // await user?.updateEmail(email).then((value) => message = "Success");
      var message = "error";
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password:AppProvider.user?.pass ?? "");
      final user = userCredential.user;

      await user?.updateEmail(email).then((value) => message = "Success");
      print(message);

      //await FirebaseAuth.instance.currentUser?.updateEmail(email);
      AppProvider.user_fire_base?.email=email;
    }
  on FirebaseAuthException catch(e){
      print(e);
    }
    try {
       response = await updateUserData1.invoke_update_user_data(
          name, email, phone, token);
      if (response == "success") {
        AppProvider appProvider = getIt<AppProvider>();
        print("z8rota");
        print(name);
        print(email);
//         Future<String> updateemail(String email, String password) async {
// //email:new email
//           var message = "error";
//           try {
//             final userCredential = await FirebaseAuth.instance
//                 .signInWithEmailAndPassword(
//                 email: _auth.currentUser!.email.toString(), password: password);
//             final user = userCredential.user;
//             await user?.updateEmail(email).then((value) => message = "Success");
//           } catch (e) {}
//           return message;
//         }
        print("llllll");
        UserDaoFireBase.updateuser(AppProvider.user_fire_base!);
       await appProvider.saveUser(
            name, token, email, phone, address, AppProvider.user?.pass ?? "");
       await appProvider.loadUser();
        for (int i = 0; i < is_changes.length; i++) {
          is_changes[i] = false;
        }
        is_change = false;
        emit(UpdateUserDataSuccess());
      }
      else {
        emit(UpdateUserDataError(response ?? ""));
      }
    }
    catch (e) {
      emit(UpdateUserDataError("some thing went wrong"));
    }
  }
  void update() {
    emit(update1());
    print("update");
    print(is_change);
  }
  Future<String?> updateUserPass(String currentPass, String password,
      String token) async {
    print("oldToken");
    print(token);
    emit(UpdateUserDataLoading());
    try {
      String? response = await updateUserData1.invoke_update_user_password(
          currentPass, password, token);
      if (response != "Error") {
        print("newToken");
        print(response);
        AppProvider appProvider = getIt<AppProvider>();
       await appProvider.saveUser(AppProvider.user?.name ?? "", response ?? "",
            AppProvider.user?.email ?? "", AppProvider.user?.phone ?? ""
            , AppProvider.user?.address ?? "", password);
        await appProvider.loadUser();
        for (int i = 0; i < is_changes.length; i++) {
          is_changes[i] = false;
        }
        is_change = false;
       await FirebaseAuth.instance.currentUser?.updatePassword(password);
        emit(UpdateUserDataSuccess());
      }
      else {
        emit(UpdateUserDataError("some thing went wrong"));
      }
    }
    catch (e) {
      emit(UpdateUserDataError("some thing went wrong"));
    }
  }

  Future<void> update_both(String name, String email, String phone,
      String token, String address, String current_pass,
      String pass) async {
    emit(UpdateUserDataLoading());
    try {
      String? response = await updateUserData1.invoke_update_user_data(
          name, email, phone, token);
      if (response == "success") {
        AppProvider appProvider = getIt<AppProvider>();
        String? response2 = await updateUserData1.invoke_update_user_password(
            current_pass, pass, token);
        if (response2 != "Error") {
        await  appProvider.saveUser(name, token, email, phone, address, pass);
         await appProvider.loadUser();
          for (int i = 0; i < is_changes.length; i++) {
            is_changes[i] = false;
          }
          is_change = false;
          emit(UpdateUserDataSuccess());
        }
        else {
          emit(UpdateUserDataError("some thing went wrong"));
        }
      }
      else {
        emit(UpdateUserDataError("some thing went wrong"));
      }
    }
    catch (e) {
      emit(UpdateUserDataError("some thing went wrong"));
    }
  }
}