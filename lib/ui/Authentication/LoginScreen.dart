import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/Common/validation.dart';
import 'package:ecommerce/ui/Authentication/forgetPasswordWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../Common/customFormField.dart';
import '../../di/di.dart';
import '../../viewModel/LoginViewModel/login_view_model_cubit.dart';
import '../../viewModel/ProivderViewModel/app_provider.dart';
import '../home/homeSuccssesTap/homeScreen.dart';
import 'Register.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var keyform = GlobalKey<FormState>();

  var cubit = getIt<LoginViewModelCubit>();


  @override
  Widget build(BuildContext context) {
     AppProvider   obj = Provider.of<AppProvider>(context);

    return BlocListener<LoginViewModelCubit, LoginViewModelState>(

        listener: (context, state) {
          if (state is LoginViewModelSuccess) {
            obj.login(state.user.name??"",state.user.token??"",state.user.email??"",state.user.pass??"");
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const hometap();
                },
              ),
              (_) => false,
            );
          }
          if (state is LoginViewModelError) {
            Navigator.of(context, rootNavigator: true).pop();
            dialogUtilites.showmsg(context, state.error);
          }
          if (state is LoginViewModelLoading) {
         dialogUtilites.lottieLoading(context, "Loading...");
          }
        },
        bloc: cubit,
        child: Scaffold(
            backgroundColor: const Color(0xFF014282),
            body: SingleChildScrollView(
              child: Form(
                key: keyform,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 155.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset("assets/images/loginRoute.png")),
                        Container(
                          margin: EdgeInsets.only(top: 35.h),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Welcome Back To Route",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text("Please sign in with your mail",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: const Color(0xffFFFFFF),
                              )),
                        ),
                        CustomFormField(
                          cubit.emailController,
                          "Enter your email address",
                          TextInputType.emailAddress,
                          false,
                          (value) {
                            if (value!.isEmpty) {
                              return "Enter your email address";
                            } else if (validation().isValidEmail(value) ==
                                false) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                          "Email",
                          lines: 1,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                          cubit.passwordController,
                          "Enter your password",
                          TextInputType.text,
                          true,
                          (value) {
                            if (value!.isEmpty) {
                              return "Enter your password";
                            }
                            return null;
                          },
                          "Password",
                          lines: 1,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
                                    screen: const forgetPasswordWidget(),
                                    withNavBar: false, settings:const RouteSettings(name: forgetPasswordWidget.routeName));

                              },
                              child: const Text("Forgot password",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ElevatedButton(
                                onHover: (value) {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 60.h),
                                    )),
                                onPressed: () {
                                  Login();
                                },
                                child: Text("Login",
                                    style: TextStyle(
                                        color: const Color(0xFF014282),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const Register();
                                        },
                                      ),
                                      (_) => false,
                                    );
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  )),
                            ]),
                      ]),
                ),
              ),
            )));
  }

  void Login() {
    if (keyform.currentState!.validate() == false) {
      return;
    }

    cubit.login();
  }
}
