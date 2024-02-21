import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../di/di.dart';
import '../../domain/useCase/resetPasswordUseCase.dart';
import '../ProivderViewModel/app_provider.dart';

part 'reset_password_state.dart';
@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  resetPasswordUseCase resetPasswordUseCase1;

  @factoryMethod ResetPasswordCubit(this.resetPasswordUseCase1) : super(ResetPasswordInitial());

  Future<void> resetPassword(String email,String password)async{
    emit(ResetPasswordLoading());
    try {
      String? result=await resetPasswordUseCase1.invoke(email, password);
      if(result=="Error"){
        emit(ResetPasswordError());
      }
      else{
        AppProvider appProvider = getIt<AppProvider>();
        appProvider.saveUser(AppProvider.user?.name??"", result??"", email, AppProvider.user?.phone??"",AppProvider.user?.address??"",password);
        appProvider.loadUser();
        emit(ResetPasswordSuccess(result));
      }
    }
    catch (e) {
      emit(ResetPasswordError());
    }
  }
}
