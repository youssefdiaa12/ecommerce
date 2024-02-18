import 'package:ecommerce/data/dataSource/authenticationDataSource.dart';
import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';

import '../model/User/User.dart';


@Injectable(as: authenticationRepository)
class authenticationRepositoryImp extends authenticationRepository {
authenticationDataSource AuthenticationDataSource;
  @factoryMethod
  authenticationRepositoryImp(this.AuthenticationDataSource);

  @override
  Future<User?> Register(String name, String email, String password, String rePassword,
      String phoneNumber) async{
    return await AuthenticationDataSource.Register(name, email, password, rePassword, phoneNumber);
  }
  Future<User?> Login(String email, String password) async{
    return await AuthenticationDataSource.Login(email, password);

  }
  Future<String?> ForgetPassword(String email) async{
    return await AuthenticationDataSource.ForgetPassword(email);
  }
  Future<String?>ResetPasswordCode(String code) async{
    String ?result= await AuthenticationDataSource.ResetPasswordCode(code);
    print(result);
    print("repo");
    return result;
  }
  Future<String?>ResetPassword(String email,String password) async{
    String ?result= await AuthenticationDataSource.ResetPassword(email, password);
    print("repo imp");
    print(result);
    return result;
  }
}
