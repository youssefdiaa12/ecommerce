// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api_Manager.dart' as _i3;
import '../data/dataSource/authenticationDataSource.dart' as _i19;
import '../data/dataSource/brandDataSource.dart' as _i23;
import '../data/dataSource/CartListDataSource.dart' as _i4;
import '../data/dataSource/categoriesDataSource.dart' as _i6;
import '../data/dataSource/productsDataSource.dart' as _i11;
import '../data/dataSource/updateUserDataSource.dart' as _i38;
import '../data/dataSource/WishListDataSource.dart' as _i14;
import '../data/dataSourceImp/authenticationDataSourceImp.dart' as _i20;
import '../data/dataSourceImp/brandsDataSourceImp.dart' as _i24;
import '../data/dataSourceImp/CartListDataSourceImp.dart' as _i5;
import '../data/dataSourceImp/categoriesDataSourceImp.dart' as _i7;
import '../data/dataSourceImp/productsDataSourceImp.dart' as _i12;
import '../data/dataSourceImp/updateUserDataSourceImp.dart' as _i39;
import '../data/dataSourceImp/WishListDataSourceImp.dart' as _i15;
import '../data/repository/authenticationRepositoryImp.dart' as _i22;
import '../data/repository/brandsRepositoryImp.dart' as _i26;
import '../data/repository/CartListRepositoryImp.dart' as _i29;
import '../data/repository/categoriesRepositoryImp.dart' as _i9;
import '../data/repository/productRepositoryImp.dart' as _i34;
import '../data/repository/updateUserDataRepositoryImp.dart' as _i52;
import '../data/repository/WishListRepositoryImp1.dart' as _i17;
import '../domain/repository/authenticationRepository.dart' as _i21;
import '../domain/repository/brandRepository.dart' as _i25;
import '../domain/repository/cartListRepository1.dart' as _i28;
import '../domain/repository/categoriesRepository.dart' as _i8;
import '../domain/repository/productRepository.dart' as _i33;
import '../domain/repository/updateUserDataRepository.dart' as _i51;
import '../domain/repository/WishListRepository1.dart' as _i16;
import '../domain/useCase/brandsUseCase.dart' as _i27;
import '../domain/useCase/CartListUseCase.dart' as _i40;
import '../domain/useCase/categoriesProductsUseCase.dart' as _i49;
import '../domain/useCase/categoriesUseCase.dart' as _i30;
import '../domain/useCase/forgetPasswordUseCase.dart' as _i31;
import '../domain/useCase/getAllProductsUseCase.dart' as _i50;
import '../domain/useCase/loginUseCase.dart' as _i32;
import '../domain/useCase/MostSellingProductsUseCase.dart' as _i45;
import '../domain/useCase/registerationUseCase.dart' as _i35;
import '../domain/useCase/resetPasswordCodeUseCase.dart' as _i36;
import '../domain/useCase/resetPasswordUseCase.dart' as _i37;
import '../domain/useCase/updateUserDataUseCase.dart' as _i53;
import '../domain/useCase/WishListUseCase.dart' as _i18;
import '../resources/responsive_ui_helper.dart' as _i13;
import '../viewModel/CartListViewModel/cart_list_view_model_cubit.dart' as _i55;
import '../viewModel/CategoriesTapViewModel/categories_view_model_cubit.dart'
    as _i41;
import '../viewModel/ForgetPasswordViewModel/forget_password_view_model_cubit.dart'
    as _i42;
import '../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart' as _i57;
import '../viewModel/LoginViewModel/login_view_model_cubit.dart' as _i43;
import '../viewModel/LovedTapViewModel/loved_tap_cubit.dart' as _i44;
import '../viewModel/Payment/payment_cubit.dart' as _i10;
import '../viewModel/productsViewModelForCategory/category_products_cubit.dart'
    as _i56;
import '../viewModel/ProivderViewModel/app_provider.dart' as _i54;
import '../viewModel/RegisterViewModel/reigster_view_model_cubit.dart' as _i46;
import '../viewModel/ResetPasswordCodeViewModel/reset_password_code_view_model_cubit.dart'
    as _i47;
import '../viewModel/resetPasswordViewModel/reset_password_cubit.dart' as _i48;
import '../viewModel/SearchViewModel/search_view_model_cubit.dart' as _i58;
import '../viewModel/updateUserDataViewModel/update_user_data_cubit.dart'
    as _i59;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.Api_Manager>(_i3.Api_Manager());
    gh.factory<_i4.CartListDataSource>(
        () => _i5.CartListDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i6.CategoriesDataSource>(
        () => _i7.categoriesDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i8.CategoriesRepository>(
        () => _i9.categoriesRepositoryImp(gh<_i6.CategoriesDataSource>()));
    gh.factory<_i10.PaymentCubit>(() => _i10.PaymentCubit());
    gh.factory<_i11.ProductsDataSource>(
        () => _i12.productsDataSourceImp(gh<_i3.Api_Manager>()));
    gh.singleton<_i13.ResponsiveUiConfig>(_i13.ResponsiveUiConfig());
    gh.factory<_i14.WishListDataSource>(
        () => _i15.WishListDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i16.WishListRepository1>(
        () => _i17.WishListRepositoryImp1(gh<_i14.WishListDataSource>()));
    gh.factory<_i18.WishListdUseCase>(
        () => _i18.WishListdUseCase(gh<_i16.WishListRepository1>()));
    gh.factory<_i19.authenticationDataSource>(
        () => _i20.authenticationDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i21.authenticationRepository>(() =>
        _i22.authenticationRepositoryImp(gh<_i19.authenticationDataSource>()));
    gh.factory<_i23.brandDataSource>(
        () => _i24.brandDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i25.brandRepository>(
        () => _i26.brandRepositoryImp(gh<_i23.brandDataSource>()));
    gh.factory<_i27.brandsUseCase>(
        () => _i27.brandsUseCase(gh<_i25.brandRepository>()));
    gh.factory<_i28.cartListRepository1>(
        () => _i29.CartlistRepositoryImp(gh<_i4.CartListDataSource>()));
    gh.factory<_i30.categoriesUseCase>(
        () => _i30.categoriesUseCase(gh<_i8.CategoriesRepository>()));
    gh.factory<_i31.forgetPasswordUseCase>(
        () => _i31.forgetPasswordUseCase(gh<_i21.authenticationRepository>()));
    gh.factory<_i32.loginUseCase>(
        () => _i32.loginUseCase(gh<_i21.authenticationRepository>()));
    gh.factory<_i33.productRepository>(
        () => _i34.productRepositoryImp(gh<_i11.ProductsDataSource>()));
    gh.factory<_i35.registerationUseCase>(
        () => _i35.registerationUseCase(gh<_i21.authenticationRepository>()));
    gh.factory<_i36.resetPasswordCodeUseCase>(() =>
        _i36.resetPasswordCodeUseCase(gh<_i21.authenticationRepository>()));
    gh.factory<_i37.resetPasswordUseCase>(
        () => _i37.resetPasswordUseCase(gh<_i21.authenticationRepository>()));
    gh.factory<_i38.updateUserDataSource>(
        () => _i39.updateUserDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i40.CartListdUseCase>(
        () => _i40.CartListdUseCase(gh<_i28.cartListRepository1>()));
    gh.factory<_i41.CategoriesViewModelCubit>(
        () => _i41.CategoriesViewModelCubit(gh<_i30.categoriesUseCase>()));
    gh.factory<_i42.ForgetPasswordViewModelCubit>(() =>
        _i42.ForgetPasswordViewModelCubit(gh<_i31.forgetPasswordUseCase>()));
    gh.factory<_i43.LoginViewModelCubit>(
        () => _i43.LoginViewModelCubit(gh<_i32.loginUseCase>()));
    gh.factory<_i44.LovedTapCubit>(
        () => _i44.LovedTapCubit(gh<_i18.WishListdUseCase>()));
    gh.factory<_i45.MostSellingProductsUseCase>(
        () => _i45.MostSellingProductsUseCase(gh<_i33.productRepository>()));
    gh.factory<_i46.ReigsterViewModelCubit>(
        () => _i46.ReigsterViewModelCubit(gh<_i35.registerationUseCase>()));
    gh.factory<_i47.ResetPasswordCodeViewModelCubit>(() =>
        _i47.ResetPasswordCodeViewModelCubit(
            gh<_i36.resetPasswordCodeUseCase>()));
    gh.factory<_i48.ResetPasswordCubit>(
        () => _i48.ResetPasswordCubit(gh<_i37.resetPasswordUseCase>()));
    gh.factory<_i49.categoriesProductsUseCase>(
        () => _i49.categoriesProductsUseCase(gh<_i33.productRepository>()));
    gh.factory<_i50.getAllProductsUseCase>(
        () => _i50.getAllProductsUseCase(gh<_i33.productRepository>()));
    gh.factory<_i51.updateUserDataRepository>(() =>
        _i52.updateUserDataRepositoryImp(gh<_i38.updateUserDataSource>()));
    gh.factory<_i53.updateUserDataUseCase>(
        () => _i53.updateUserDataUseCase(gh<_i51.updateUserDataRepository>()));
    gh.singleton<_i54.AppProvider>(_i54.AppProvider(
      gh<_i18.WishListdUseCase>(),
      gh<_i40.CartListdUseCase>(),
    ));
    gh.factory<_i55.CartListViewModelCubit>(() => _i55.CartListViewModelCubit(
          gh<_i40.CartListdUseCase>(),
          gh<_i49.categoriesProductsUseCase>(),
        ));
    gh.factory<_i56.CategoryProductsCubit>(
        () => _i56.CategoryProductsCubit(gh<_i49.categoriesProductsUseCase>()));
    gh.factory<_i57.HomeTapViewModelCubit>(() => _i57.HomeTapViewModelCubit(
          gh<_i30.categoriesUseCase>(),
          gh<_i27.brandsUseCase>(),
          gh<_i45.MostSellingProductsUseCase>(),
        ));
    gh.factory<_i58.SearchViewModelCubit>(
        () => _i58.SearchViewModelCubit(gh<_i50.getAllProductsUseCase>()));
    gh.factory<_i59.UpdateUserDataCubit>(
        () => _i59.UpdateUserDataCubit(gh<_i53.updateUserDataUseCase>()));
    return this;
  }
}
