import '../../data/model/User/User.dart';

abstract class authenticationRepository {
  Future<User?> Register(String name, String email, String password,String rePassword, String phoneNumber);
Future<User?> Login(String email, String password);
Future<String?> ForgetPassword(String email);
Future<String?>ResetPasswordCode(String code);
Future<String?>ResetPassword(String email,String newPass);
}