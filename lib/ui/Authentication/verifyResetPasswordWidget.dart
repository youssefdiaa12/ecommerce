import 'package:ecommerce/ui/Authentication/resetPasswordWidget.dart';
import 'package:ecommerce/viewModel/ResetPasswordCodeViewModel/reset_password_code_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../di/di.dart';
import '../../resources/responsive_ui_helper.dart';

class verifyResetPasswordWidget extends StatefulWidget {
  static const routeName = 'verifyResetPasswordWidget';
  final String email;
  const verifyResetPasswordWidget({Key? key, required this.email}) : super(key: key);
  @override
  State<verifyResetPasswordWidget> createState() => _verifyResetPasswordWidgetState();
}

class _verifyResetPasswordWidgetState extends State<verifyResetPasswordWidget> {
  var cubit = getIt<ResetPasswordCodeViewModelCubit>();
  var keyform = GlobalKey<FormState>();
  TextEditingController codelController = TextEditingController();
  bool _onEditing = true;

  @override
  Widget build(BuildContext context) {
    var size = getIt<ResponsiveUiConfig>()..initialize(context);
    return BlocListener<ResetPasswordCodeViewModelCubit, ResetPasswordCodeViewModelState>(
        listenWhen: (previous, current) {
          if(current is ResetPasswordViewModelSuccessful){
            return true;
          }
          if(current is ResetPasswordViewModelError){
            return true;
          }
          if(current is ResetPasswordViewModelLoading){
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is ResetPasswordViewModelSuccessful) {
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
                                screen:  ResetPasswordWidget(email:widget.email),
                                withNavBar: false, settings: RouteSettings(name: ResetPasswordWidget.routeName));


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
                                    "Reset password",
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
          if (state is ResetPasswordViewModelError) {
            Navigator.of(context, rootNavigator: true).pop();
            dialogUtilites.lottieError(context, "Invalid verification code");
          }
          if (state is ResetPasswordViewModelLoading) {
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
                  margin: EdgeInsets.symmetric(vertical: size.screenHeight * 0.4),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset("assets/images/loginRoute.png")),
                        SizedBox(
                          height: 15.h,
                        ),
                        VerificationCode(
                          textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                          keyboardType: TextInputType.number,
                          underlineColor: Colors.white, // If this is null it will use primaryColor: Colors.red from Theme
                          length: 6,
                          cursorColor: Colors.blue, // If this is null it will default to the ambient
                          // clearAll is NOT required, you can delete it
                          // takes any widget, so you can implement your design
                          clearAll: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 24.0.h),
                            child: Text(
                              'clear all',
                              style: TextStyle(fontSize: 18.0.sp, color: Colors.white),
                            ),
                          ),
                          onCompleted: (String value) {
                            setState(() {
                              codelController.text = value;
                            });
                          },
                          onEditing: (bool value) {
                            setState(() {
                              _onEditing = value;
                            });
                            if (!_onEditing) FocusScope.of(context).unfocus();
                          },
                        ),
                        SizedBox(height: 25.h,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async{

                                  invoke();
                                },
                                child: SizedBox( // Wrap the TextButton with SizedBox
                                  width: 200.0, // Set the desired width
                                  child: Center( // Center the TextButton within the SizedBox
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        color: const Color(0xFF014282),
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
    cubit.resetPassword(codelController.text);
  }
}
