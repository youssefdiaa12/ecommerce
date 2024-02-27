import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Common/customFormField.dart';
import '../../di/di.dart';
import '../../viewModel/ProivderViewModel/app_provider.dart';
import '../../viewModel/resetPasswordViewModel/reset_password_cubit.dart';
import '../home/homeSuccssesTap/home_screen.dart';
import 'package:provider/provider.dart';

class ResetPasswordWidget extends StatefulWidget {
  static const routeName = 'resetPasswordWidget';
 final  String email;
  const ResetPasswordWidget({Key? key, required this.email}) : super(key: key);
  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  var keyform = GlobalKey<FormState>();
  TextEditingController passwordlController = TextEditingController();

  var cubit = getIt<ResetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    print("email is ${widget.email}");
    AppProvider obj = Provider.of<AppProvider>(context);
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
listenWhen: (previous, current) {
  if(current is ResetPasswordSuccess){
    return true;
  }
  if(current is ResetPasswordError){
    return true;
  }
  if(current is ResetPasswordLoading){
    return true;
  }
  return false;
},
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            obj.updateUserPassword(passwordlController.text,state.result??"");
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const HomeScreen();
                },
              ),
                  (_) => false,
            );
          }
          if (state is ResetPasswordError) {
            Navigator.of(context, rootNavigator: true).pop();
            dialogUtilites.lottieError(context, "reset code not verified");
          }
          if (state is ResetPasswordLoading) {
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
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                          passwordlController,
                          "Enter your new password",
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
                                  resetPassword();
                                },
                                child: Text("Save",
                                    style: TextStyle(
                                        color: const Color(0xFF014282),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),

                      ]),
                ),
              ),
            )));
  }

  void resetPassword() {
    if (keyform.currentState!.validate() == false) {
      return;
    }

    cubit.resetPassword(widget.email, passwordlController.text);
  }
}
