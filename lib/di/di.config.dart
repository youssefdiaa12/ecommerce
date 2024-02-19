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
import '../data/dataSource/authenticationDataSource.dart' as _i18;
import '../data/dataSource/brandDataSource.dart' as _i22;
import '../data/dataSource/CartListDataSource.dart' as _i4;
import '../data/dataSource/categoriesDataSource.dart' as _i6;
import '../data/dataSource/productsDataSource.dart' as _i10;
import '../data/dataSource/WishListDataSource.dart' as _i13;
import '../data/dataSourceImp/authenticationDataSourceImp.dart' as _i19;
import '../data/dataSourceImp/brandsDataSourceImp.dart' as _i23;
import '../data/dataSourceImp/CartListDataSourceImp.dart' as _i5;
import '../data/dataSourceImp/categoriesDataSourceImp.dart' as _i7;
import '../data/dataSourceImp/productsDataSourceImp.dart' as _i11;
import '../data/dataSourceImp/WishListDataSourceImp.dart' as _i14;
import '../data/repository/authenticationRepositoryImp.dart' as _i21;
import '../data/repository/brandsRepositoryImp.dart' as _i25;
import '../data/repository/CartListRepositoryImp.dart' as _i28;
import '../data/repository/categoriesRepositoryImp.dart' as _i9;
import '../data/repository/productRepositoryImp.dart' as _i33;
import '../data/repository/WishtListRepositoryImp.dart' as _i16;
import '../domain/repository/authenticationRepository.dart' as _i20;
import '../domain/repository/brandRepository.dart' as _i24;
import '../domain/repository/cartListRepository1.dart' as _i27;
import '../domain/repository/categoriesRepository.dart' as _i8;
import '../domain/repository/productRepository.dart' as _i32;
import '../domain/repository/wishListRepository.dart' as _i15;
import '../domain/useCase/brandsUseCase.dart' as _i26;
import '../domain/useCase/CartListUseCase.dart' as _i38;
import '../domain/useCase/categoriesProductsUseCase.dart' as _i47;
import '../domain/useCase/categoriesUseCase.dart' as _i29;
import '../domain/useCase/forgetPasswordUseCase.dart' as _i30;
import '../domain/useCase/loginUseCase.dart' as _i31;
import '../domain/useCase/MostSellingProductsUseCase.dart' as _i43;
import '../domain/useCase/registerationUseCase.dart' as _i34;
import '../domain/useCase/resetPasswordCodeUseCase.dart' as _i35;
import '../domain/useCase/resetPasswordUseCase.dart' as _i36;
import '../domain/useCase/WishListUseCases.dart' as _i17;
import '../resources/responsive_ui_helper.dart' as _i12;
import '../viewModel/CartListViewModel/cart_list_view_model_cubit.dart' as _i48;
import '../viewModel/CategoriesTapViewModel/categories_view_model_cubit.dart'
    as _i39;
import '../viewModel/ForgetPasswordViewModel/forget_password_view_model_cubit.dart'
    as _i40;
import '../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart' as _i50;
import '../viewModel/LoginViewModel/login_view_model_cubit.dart' as _i41;
import '../viewModel/LovedTapViewModel/loved_tap_cubit.dart' as _i42;
import '../viewModel/productsViewModelForCategory/category_products_cubit.dart'
    as _i49;
import '../viewModel/ProivderViewModel/app_provider.dart' as _i37;
import '../viewModel/RegisterViewModel/reigster_view_model_cubit.dart' as _i44;
import '../viewModel/ResetPasswordCodeViewModel/reset_password_code_view_model_cubit.dart'
    as _i45;
import '../viewModel/resetPasswordViewModel/reset_password_cubit.dart' as _i46;

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
    gh.factory<_i10.ProductsDataSource>(
        () => _i11.productsDataSourceImp(gh<_i3.Api_Manager>()));
    gh.singleton<_i12.ResponsiveUiConfig>(_i12.ResponsiveUiConfig());
    gh.factory<_i13.WishListDataSource>(
        () => _i14.WishListDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i15.WishListRepository>(
        () => _i16.addToCartListRepositoryImp(gh<_i13.WishListDataSource>()));
    gh.factory<_i17.WishListdUseCase>(
        () => _i17.WishListdUseCase(gh<_i15.WishListRepository>()));
    gh.factory<_i18.authenticationDataSource>(
        () => _i19.authenticationDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i20.authenticationRepository>(() =>
        _i21.authenticationRepositoryImp(gh<_i18.authenticationDataSource>()));
    gh.factory<_i22.brandDataSource>(
        () => _i23.brandDataSourceImp(gh<_i3.Api_Manager>()));
    gh.factory<_i24.brandRepository>(
        () => _i25.brandRepositoryImp(gh<_i22.brandDataSource>()));
    gh.factory<_i26.brandsUseCase>(
        () => _i26.brandsUseCase(gh<_i24.brandRepository>()));
    gh.factory<_i27.cartListRepository1>(
        () => _i28.CartlistRepositoryImp(gh<_i4.CartListDataSource>()));
    gh.factory<_i29.categoriesUseCase>(
        () => _i29.categoriesUseCase(gh<_i8.CategoriesRepository>()));
    gh.factory<_i30.forgetPasswordUseCase>(
        () => _i30.forgetPasswordUseCase(gh<_i20.authenticationRepository>()));
    gh.factory<_i31.loginUseCase>(
        () => _i31.loginUseCase(gh<_i20.authenticationRepository>()));
    gh.factory<_i32.productRepository>(
        () => _i33.productRepositoryImp(gh<_i10.ProductsDataSource>()));
    gh.factory<_i34.registerationUseCase>(
        () => _i34.registerationUseCase(gh<_i20.authenticationRepository>()));
    gh.factory<_i35.resetPasswordCodeUseCase>(() =>
        _i35.resetPasswordCodeUseCase(gh<_i20.authenticationRepository>()));
    gh.factory<_i36.resetPasswordUseCase>(
        () => _i36.resetPasswordUseCase(gh<_i20.authenticationRepository>()));
    gh.singleton<_i37.AppProvider>(
        _i37.AppProvider(gh<_i17.WishListdUseCase>()));
    gh.factory<_i38.CartListdUseCase>(
        () => _i38.CartListdUseCase(gh<_i27.cartListRepository1>()));
    gh.factory<_i39.CategoriesViewModelCubit>(
        () => _i39.CategoriesViewModelCubit(gh<_i29.categoriesUseCase>()));
    gh.factory<_i40.ForgetPasswordViewModelCubit>(() =>
        _i40.ForgetPasswordViewModelCubit(gh<_i30.forgetPasswordUseCase>()));
    gh.factory<_i41.LoginViewModelCubit>(
        () => _i41.LoginViewModelCubit(gh<_i31.loginUseCase>()));
    gh.factory<_i42.LovedTapCubit>(
        () => _i42.LovedTapCubit(gh<_i17.WishListdUseCase>()));
    gh.factory<_i43.MostSellingProductsUseCase>(
        () => _i43.MostSellingProductsUseCase(gh<_i32.productRepository>()));
    gh.factory<_i44.ReigsterViewModelCubit>(
        () => _i44.ReigsterViewModelCubit(gh<_i34.registerationUseCase>()));
    gh.factory<_i45.ResetPasswordCodeViewModelCubit>(() =>
        _i45.ResetPasswordCodeViewModelCubit(
            gh<_i35.resetPasswordCodeUseCase>()));
    gh.factory<_i46.ResetPasswordCubit>(
        () => _i46.ResetPasswordCubit(gh<_i36.resetPasswordUseCase>()));
    gh.factory<_i47.categoriesProductsUseCase>(
        () => _i47.categoriesProductsUseCase(gh<_i32.productRepository>()));
    gh.factory<_i48.CartListViewModelCubit>(
        () => _i48.CartListViewModelCubit(gh<_i38.CartListdUseCase>()));
    gh.factory<_i49.CategoryProductsCubit>(
        () => _i49.CategoryProductsCubit(gh<_i47.categoriesProductsUseCase>()));
    gh.factory<_i50.HomeTapViewModelCubit>(() => _i50.HomeTapViewModelCubit(
          gh<_i29.categoriesUseCase>(),
          gh<_i26.brandsUseCase>(),
          gh<_i43.MostSellingProductsUseCase>(),
        ));
    return this;
  }
}
