import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/model/Category.dart';
import '../../domain/useCase/categoriesUseCase.dart';

part 'categories_view_model_state.dart';
@injectable
class CategoriesViewModelCubit extends Cubit<CategoriesViewModelState> {
  categoriesUseCase categoriesUseCase1;
  @factoryMethod CategoriesViewModelCubit(this.categoriesUseCase1) : super(CategoriesViewModelInitial());
  void getData() async {
    emit(CategoriesViewModelLoading());
    try {
      List<Category> categories = await categoriesUseCase1.invoke();
      emit(CategoriesViewModelSuccessful(categories));
    } catch (e) {
      emit(CategoriesViewModelError(e.toString()));
    }
  }

}
