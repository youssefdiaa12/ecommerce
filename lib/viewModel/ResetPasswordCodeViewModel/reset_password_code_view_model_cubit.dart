import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/useCase/resetPasswordCodeUseCase.dart';

part 'reset_password_code_view_model_state.dart';
@injectable
class ResetPasswordCodeViewModelCubit extends Cubit<ResetPasswordCodeViewModelState> {
  resetPasswordCodeUseCase resetPasswordUseCase1;
 @factoryMethod ResetPasswordCodeViewModelCubit(this.resetPasswordUseCase1) : super(ResetPasswordViewModelInitial());

 Future<void> resetPassword(String code)async{
   emit(ResetPasswordViewModelLoading());
   try {
     String? result = await resetPasswordUseCase1.invoke(code);
     print("koko");
     if(result!="Success"){
       print(result);
       emit(ResetPasswordViewModelError(result??""));
     }
     else {
       emit(ResetPasswordViewModelSuccessful());
     }
   }
   catch (e) {
     emit(ResetPasswordViewModelError(e.toString()));
   }

 }


}
