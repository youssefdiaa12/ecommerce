import 'package:ecommerce/Common/validation.dart';
import 'package:ecommerce/ui/Authentication/LoginScreen.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeScreen.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';

import '../../Common/customFormField.dart';
import '../../di/di.dart';
import '../../viewModel/RegisterViewModel/reigster_view_model_cubit.dart';

class Register extends StatefulWidget {
  static const routeName = 'Register';
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var keyform = GlobalKey<FormState>();
  var cubit = getIt<ReigsterViewModelCubit>();
  @override
  Widget build(BuildContext context) {
    AppProvider obj = Provider.of<AppProvider>(context);
    return BlocListener <ReigsterViewModelCubit, ReigsterViewModelState>(
        listener:
        (context,state){
          if(state is ReigsterViewModelSuccess){
            obj.register(cubit.emailController.text,cubit.userName.text
                ,state.user.token??"",cubit.phoneNumber.text);
            Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const hometap();
                },
              ),
                  (_) => false,
            );
          }
          if(state is ReigsterViewModelError){
            Navigator.of(context,rootNavigator: true).pop();
         dialogUtilites.lottieError(context, state.error);
          }
          if(state is ReigsterViewModelLoading){
            dialogUtilites.lottieLoading(context, "Loading...");
          }
        },
      bloc: cubit,
      child:
           Scaffold(
              backgroundColor: const Color(0xFF014282),
              body:SingleChildScrollView(
                child: Form(
                  key: keyform,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 120.h),
                    child:Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset("assets/images/loginRoute.png")),
                          CustomFormField(
                            cubit.userName,
                            "Enter your name",
                            TextInputType.text,
                            false,
                                (value){
                             if(value!.isEmpty||value.length<3){
                               return "Enter your name";
                             }
                            },
                            "Full Name",
                            lines: 1,
                          ),
                          SizedBox(height: 15.h,),
                          CustomFormField(
                            cubit.phoneNumber,
                            "Enter your phone number",
                            TextInputType.phone,
                            false,
                                (value){
                            if(value!.isEmpty||value.length<11){
                              return "Enter your phone number";
                            }
                            },
                            "Phone Number",
                            lines: 1,
                          ),
                          SizedBox(height: 15.h,),
                          CustomFormField(
                            cubit.emailController,
                            "Enter your email address",
                            TextInputType.emailAddress,
                            false,
                                (value){
                             if(value!.isEmpty||!value.contains("@")||validation().isValidEmail(value)==false){
                               return "Enter your email address";
                             }
                             return null;
                            },
                            "Email",
                            lines: 1,
                          ),
                          SizedBox(height: 15.h,),
                          CustomFormField(
                            cubit.passwordController,
                            "Enter your password",
                            TextInputType.text,
                            true,
                                (value){
                           if(value!.isEmpty||value.length<6){
                             return "Enter your password";
                           }
                            },
                            "Password",
                            lines: 1,
                          ),
                          SizedBox(height: 15.h,),
                          CustomFormField(
                            cubit.confirmPasswordController,
                            "Confirm your password",
                            TextInputType.text,
                            true,
                                (value){
                             if(value!=cubit.passwordController.text||value!.isEmpty){
                               return "Password doesn't match";
                             }
                             return null;
                                }
                            ,
                            "Confirm Password",
                            lines: 1,
                          ),
                          SizedBox(height: 45.h,),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.w),
                              child: ElevatedButton(
                                  onHover: (value) {

                                  },
                                  style: ButtonStyle(

                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          )
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(double.infinity, 65.h),
                                      )
                                  ),
                                  onPressed: (){
                                    createAccount();
                                  }, child: Text("Sign Up",
                                  style: TextStyle(
                                      color: const Color(0xFF014282),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold
                                  ))),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),),
                                TextButton(onPressed: (){
                                  Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const LoginScreen();
                                      },
                                    ),
                                        (_) => false,
                                  );

                                }, child: Text("Login",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),)),
                              ]
                          ),
                        ]
                    ),
                  ),
                ),

              )
          )
    );

        }

  void createAccount() {
    if(keyform.currentState!.validate()==false){
    return;
    }

    cubit.register();
  }
}
