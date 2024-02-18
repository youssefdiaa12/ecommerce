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
import '../data/dataSource/authenticationDataSource.dart' as _i15;
import '../data/dataSource/brandDataSource.dart' as _i19;
import '../data/dataSource/CartListDataSource.dart' as _i4;
import '../data/dataSource/categoriesDataSource.dart' as _i6;
import '../data/dataSource/productsDataSource.dart' as _i10;
import '../data/dataSourceImp/authenticationDataSourceImp.dart' as _i16;
import '../data/dataSourceImp/brandsDataSourceImp.dart' as _i20;
import '../data/dataSourceImp/CartListDataSourceImp.dart' as _i5;
import '../data/dataSourceImp/categoriesDataSourceImp.dart' as _i7;
import '../data/dataSourceImp/productsDataSourceImp.dart' as _i11;
import '../data/repository/addToCartListRepositoryImp.dart' as _i14;
import '../data/repository/authenticationRepositoryImp.dart' as _i18;
import '../data/repository/brandsRepositoryImp.dart' as _i22;
import '../data/repository/categoriesRepositoryImp.dart' as _i9;
import '../data/repository/productRepositoryImp.dart' as _i28;
import '../domain/repository/authenticationRepository.dart' as _i17;
import '../domain/repository/brandRepository.dart' as _i21;
import '../domain/repository/CartListRepository.dart' as _i13;
import '../domain/repository/categoriesRepository.dart' as _i8;
import '../domain/repository/productRepository.dart' as _i27;
import '../domain/useCase/brandsUseCase.dart' as _i23;
import '../domain/useCase/CartListUseCases.dart' as _i32;
import '../domain/useCase/categoriesProductsUseCase.dart' as _i41;
import '../domain/useCase/categoriesUseCase.dart' as _i24;
import '../domain/useCase/forgetPasswordUseCase.dart' as _i25;
import '../domain/useCase/loginUseCase.dart' as _i26;
import '../domain/useCase/MostSellingProductsUseCase.dart' as _i37;
import '../domain/useCase/registerationUseCase.dart' as _i29;
import '../domain/useCase/resetPasswordCodeUseCase.dart' as _i30;
import '../domain/useCase/resetPasswordUseCase.dart' as _i31;
import '../resources/responsive_ui_helper.dart' as _i12;
import '../viewModel/CategoriesTapViewModel/categories_view_model_cubit.dart'
    as _i33;
import '../viewModel/ForgetPasswordViewModel/forget_password_view_model_cubit.dart'
    as _i34;
import '../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart' as _i44;
import '../viewModel/LoginViewModel/login_view_model_cubit.dart' as _i35;
import '../viewModel/LovedTapViewModel/loved_tap_cubit.dart' as _i36;
import '../viewModel/productsViewModelForCategory/category_products_cubit.dart'
    as _i43;
import '../viewModel/ProivderViewModel/app_provider.dart' as _i42;
import '../viewModel/RegisterViewModel/reigster_view_model_cubit.dart' as _i38;
import '../viewModel/ResetPasswordCodeViewModel/reset_password_code_view_model_cubit.dart'
    as _i39;
import '../viewModel/resetPasswordViewModel/reset_password_cubit.dart' as _i40;

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
        () => _i5.addProductToCartListDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i6.CategoriesDataSource>(
        () => _i7.categoriesDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i8.CategoriesRepository>(
        () => _i9.categoriesRepositoryImp(gh<_i6.CategoriesDataSource>()));
    gh.factory<_i10.ProductsDataSource>(
        () => _i11.productsDataSourceImp(gh<_i3.Api_Manager>()));
    gh.singleton<_i12.ResponsiveUiConfig>(_i12.ResponsiveUiConfig());
    gh.factory<_i13.addProductToCartListRepository>(
        () => _i14.addToCartListRepositoryImp(gh<_i4.CartListDataSource>()));
    gh.factory<_i15.authenticationDataSource>(
        () => _i16.authenticationDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i17.authenticationRepository>(() =>
        _i18.authenticationRepositoryImp(gh<_i15.authenticationDataSource>()));
    gh.factory<_i19.brandDataSource>(
        () => _i20.brandDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i21.brandRepository>(
        () => _i22.brandRepositoryImp(gh<_i19.brandDataSource>()));
    gh.factory<_i23.brandsUseCase>(
        () => _i23.brandsUseCase(gh<_i21.brandRepository>()));
    gh.factory<_i24.categoriesUseCase>(
        () => _i24.categoriesUseCase(gh<_i8.CategoriesRepository>()));
    gh.factory<_i25.forgetPasswordUseCase>(
        () => _i25.forgetPasswordUseCase(gh<_i17.authenticationRepository>()));
    gh.factory<_i26.loginUseCase>(
        () => _i26.loginUseCase(gh<_i17.authenticationRepository>()));
    gh.factory<_i27.productRepository>(
        () => _i28.productRepositoryImp(gh<_i10.ProductsDataSource>()));
    gh.factory<_i29.registerationUseCase>(
        () => _i29.registerationUseCase(gh<_i17.authenticationRepository>()));
    gh.factory<_i30.resetPasswordCodeUseCase>(() =>
        _i30.resetPasswordCodeUseCase(gh<_i17.authenticationRepository>()));
    gh.factory<_i31.resetPasswordUseCase>(
        () => _i31.resetPasswordUseCase(gh<_i17.authenticationRepository>()));
    gh.factory<_i32.CartListdUseCase>(
        () => _i32.CartListdUseCase(gh<_i13.addProductToCartListRepository>()));
    gh.factory<_i33.CategoriesViewModelCubit>(
        () => _i33.CategoriesViewModelCubit(gh<_i24.categoriesUseCase>()));
    gh.factory<_i34.ForgetPasswordViewModelCubit>(() =>
        _i34.ForgetPasswordViewModelCubit(gh<_i25.forgetPasswordUseCase>()));
    gh.factory<_i35.LoginViewModelCubit>(
        () => _i35.LoginViewModelCubit(gh<_i26.loginUseCase>()));
    gh.factory<_i36.LovedTapCubit>(
        () => _i36.LovedTapCubit(gh<_i32.CartListdUseCase>()));
    gh.factory<_i37.MostSellingProductsUseCase>(
        () => _i37.MostSellingProductsUseCase(gh<_i27.productRepository>()));
    gh.factory<_i38.ReigsterViewModelCubit>(
        () => _i38.ReigsterViewModelCubit(gh<_i29.registerationUseCase>()));
    gh.factory<_i39.ResetPasswordCodeViewModelCubit>(() =>
        _i39.ResetPasswordCodeViewModelCubit(
            gh<_i30.resetPasswordCodeUseCase>()));
    gh.factory<_i40.ResetPasswordCubit>(
        () => _i40.ResetPasswordCubit(gh<_i31.resetPasswordUseCase>()));
    gh.factory<_i41.categoriesProductsUseCase>(
        () => _i41.categoriesProductsUseCase(gh<_i27.productRepository>()));
    gh.singleton<_i42.AppProvider>(
        _i42.AppProvider(gh<_i32.CartListdUseCase>()));
    gh.factory<_i43.CategoryProductsCubit>(
        () => _i43.CategoryProductsCubit(gh<_i41.categoriesProductsUseCase>()));
    gh.factory<_i44.HomeTapViewModelCubit>(() => _i44.HomeTapViewModelCubit(
          gh<_i24.categoriesUseCase>(),
          gh<_i23.brandsUseCase>(),
          gh<_i37.MostSellingProductsUseCase>(),
        ));
    return this;
  }
}
