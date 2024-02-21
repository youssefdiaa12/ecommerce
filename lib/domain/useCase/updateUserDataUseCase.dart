import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/User/User.dart';
import '../../di/di.dart';
import '../../viewModel/ProivderViewModel/app_provider.dart';
import '../repository/updateUserDataRepository.dart';
@injectable
class updateUserDataUseCase{

  updateUserDataRepository updateUserDataRepository1;
  @factoryMethod updateUserDataUseCase(this.updateUserDataRepository1);

  Future<String?> invoke_update_user_data(String name, String email, String phone, String token)async{
    return await updateUserDataRepository1.updateUser(name, email, phone, token);
  }
  Future<String?> invoke_update_user_password(String currentPass,String password, String token)async{
    return await updateUserDataRepository1.updateUserPass(currentPass, password, token);
  }
}
