import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/resources/app_themes.dart';
import 'package:ecommerce/resources/blocObserver.dart';
import 'package:ecommerce/splash_screen.dart';
import 'package:ecommerce/ui/Authentication/LoginScreen.dart';
import 'package:ecommerce/ui/Authentication/Register.dart';
import 'package:ecommerce/ui/Authentication/forgetPasswordWidget.dart';
import 'package:ecommerce/ui/Authentication/resetPasswordWidget.dart';
import 'package:ecommerce/ui/Authentication/verifyResetPasswordWidget.dart';
import 'package:ecommerce/ui/home/CartList/CartListWidget.dart';
import 'package:ecommerce/ui/home/CategoriesTap/categoryProductsWidget.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productDetailsCartWidget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/home_screen.dart';
import 'package:ecommerce/ui/home/SearchScreen/search_screen.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'data/Services/disk_storage.dart';
import 'di/di.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  var provider1 = getIt<AppProvider>();
  await provider1.loggedin();

 // await provider1.logout();

  runApp(
      MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context) => provider1),
        ChangeNotifierProvider(create: (context) => disk_storge()),
      ],
        child: const MyApp(),
      ),
  );

  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ResponsiveSizer(
      builder: (context, orientation, screenType) =>
      ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowMaterialGrid: false,
          showSemanticsDebugger: false,
          theme:MyThemeData.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute:   SplashPage.routeName,
          routes: {
            HomeScreen.routeName:(context)=>const HomeScreen(),
            CategorProductsWidget.routeName:(context)=>const CategorProductsWidget(),
            LoginScreen.routeName:(context)=> const LoginScreen(),
            SplashPage.routeName:(context)=>const SplashPage(),
            Register.routeName:(context)=>const Register(),
            verifyResetPasswordWidget.routeName:(context)=> verifyResetPasswordWidget(email: ""),
            forgetPasswordWidget.routeName:(context)=>const forgetPasswordWidget(),
            ResetPasswordWidget.routeName:(context)=>ResetPasswordWidget(email:""),
            productDetailsCartWidget.routeName:(context)=> productDetailsCartWidget(Product()),
            CartListWidget.routeName:(context)=> CartListWidget(),
            searchScreen.routeName:(context)=>const searchScreen(),
          },
        ),
      ),
    );
  }
}

