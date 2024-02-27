import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../domain/useCase/forgetPasswordUseCase.dart';

part 'forget_password_view_model_state.dart';
@injectable
class ForgetPasswordViewModelCubit extends Cubit<ForgetPasswordViewModelState> {
  forgetPasswordUseCase forgetPasswordUseCase1;
  @factoryMethod ForgetPasswordViewModelCubit(this.forgetPasswordUseCase1) : super(ForgetPasswordViewModelInitial());

  Future<void> invoke(String email)async{
    emit(ForgetPasswordViewModelLoading());
    try {
      String? msg = await forgetPasswordUseCase1.invoke(email);
      if (msg != "Reset code sent to your email") {
        emit(ForgetPasswordViewModelError(msg));
      }
      else {
        emit(ForgetPasswordViewModelSuccess(msg));
      }
    }
    catch(e){
      emit(ForgetPasswordViewModelError(e.toString()));
    }
  }
}
