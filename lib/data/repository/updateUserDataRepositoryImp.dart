import 'package:injectable/injectable.dart';

import '../../domain/repository/updateUserDataRepository.dart';
import '../dataSource/updateUserDataSource.dart';
@Injectable(as: updateUserDataRepository)
class updateUserDataRepositoryImp extends updateUserDataRepository {
  updateUserDataSource UpdateUserData;
  @factoryMethod updateUserDataRepositoryImp(this.UpdateUserData);
  @override
  Future<String> updateUser(String name, String email, String phone, String token) {
    return UpdateUserData.updateUser(name, email, phone, token);
  }
  @override
  Future<String> updateUserPass(String currentPass,String password, String token) {
    return UpdateUserData.updateUserPass(currentPass, password, token);
  }
}