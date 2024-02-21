import 'package:ecommerce/data/api_Manager.dart';
import 'package:injectable/injectable.dart';

import '../dataSource/updateUserDataSource.dart';
@Injectable(as: updateUserDataSource)
class updateUserDataSourceImp extends updateUserDataSource {
  Api_Manager api_manager;
  @factoryMethod updateUserDataSourceImp(this.api_manager);
  @override
  Future<String> updateUser(String name, String email, String phone, String token) {
    return api_manager.updateUserData(name, email, phone, token);
  }
  @override
  Future<String> updateUserPass(String currentPass,String password, String token) {
    return api_manager.updatePassword(currentPass, password, token);
  }
}