import 'package:ecommerce/ui/Authentication/verifyResetPasswordWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../Common/customFormField.dart';
import '../../Common/validation.dart';
import '../../di/di.dart';
import '../../viewModel/ForgetPasswordViewModel/forget_password_view_model_cubit.dart';

class forgetPasswordWidget extends StatefulWidget {
  static const routeName = 'forgetPasswordWidget';
  const forgetPasswordWidget({Key? key}) : super(key: key);

  @override
  State<forgetPasswordWidget> createState() => _forgetPasswordWidgetState();
}

class _forgetPasswordWidgetState extends State<forgetPasswordWidget> {
  var cubit = getIt<ForgetPasswordViewModelCubit>();
  var keyform = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordViewModelCubit, ForgetPasswordViewModelState>(
      listenWhen: (previous, current) {
        if(current is ForgetPasswordViewModelSuccess){
          return true;
        }
        if(current is ForgetPasswordViewModelError){
          return true;
        }
        if(current is ForgetPasswordViewModelLoading){
          return true;
        }
        return false;
      },
        listener: (context, state) {
          if (state is ForgetPasswordViewModelSuccess) {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    //decrease height of the dialog
                    insetPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/animations/codeSent.json",
                            fit: BoxFit.cover,
                            height: 180.h,
                            width: 180.w,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
                                screen:  verifyResetPasswordWidget(email: emailController.text),
                                withNavBar: false, settings:const RouteSettings(name: verifyResetPasswordWidget.routeName,

                                ));


                          },
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3482F7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Verfication Code Sent",
                                    style: TextStyle(
                                        color: Colors.white),
                                  ),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              ),
                            ),
                          ))
                    ],
                  );
                });

        }
          if (state is ForgetPasswordViewModelError) {
            Navigator.of(context, rootNavigator: true).pop();
            dialogUtilites.lottieError(context, state.msg??"");
          }
          if (state is ForgetPasswordViewModelLoading) {
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
                        CustomFormField(
                          emailController,
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    invoke();
                                  },
                                  child: Text(
                                    "Send verification code",
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

  void invoke() {
    if (keyform.currentState!.validate() == false) {
      return;
    }
    cubit.invoke(emailController.text);
  }

}
