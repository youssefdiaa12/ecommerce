

import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/viewModel/updateUserDataViewModel/update_user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../Common/requiredLoginWidget.dart';
import '../../../di/di.dart';
import '../../../domain/useCase/updateUserDataUseCase.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../Authentication/LoginScreen.dart';
import 'MyAccoutBody.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title:null,
        actions: [],
        backgroundColor: Colors.white,
        leading: Image.asset("assets/images/route.png"),
      ),
      body: BlocProvider(
        create: (context) =>
            UpdateUserDataCubit(getIt<updateUserDataUseCase>())..intializeData(),
        child: BlocConsumer<UpdateUserDataCubit,UpdateUserDataState>(
          listener: (context, state) {
            if(state is UpdateUserDataSuccess){
              Navigator.pop(dialogUtilites.dialogContext!);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      //decrease height of the dialog
                      insetPadding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/animations/succsses.json",
                              fit: BoxFit.cover,
                              height: 180.h,
                              width: 180.w,
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Text("Updated Successfully",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Poppins",
                                )),
                          ],
                        ),
                      ),
                    );
                  });
            }

            if(state is UpdateUserDataError){
              Navigator.pop(dialogUtilites.dialogContext!);

              dialogUtilites.lottieError(context, state.error??"");
            }
            if(state is UpdateUserDataLoading){
              dialogUtilites.lottieLoading(context, "Loading...");
            }
            if(state is verfiyUser){
              Navigator.pop(dialogUtilites.dialogContext!);
              dialogUtilites.lottieVerify(context,"please verify your email");
            }
          },
          listenWhen: (previous, current) {
            if(current is UpdateUserDataSuccess){
              return true;
            }
            if(current is UpdateUserDataError){
              return true;
            }
            if(current is UpdateUserDataLoading){
              return true;
            }
            if(current is verfiyUser){
              return true;
            }

            return false;
          },
            builder: (context, state) {
            if(state is unAuthorized){
              return requiredLoginWidget(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginScreen();
                      },
                    ),
                        (_) => false,
                  );
                },
                text: "login",
              );

            }
              if(state is UpdateUserDataSuccess){
                print("emalo");
                print(AppProvider.user?.email);
              return  MyAccountBody();
              }
              return MyAccountBody();
            },
            buildWhen: (previous, current) {
              if(current is UpdateUserDataSuccess){
                return true;
              }
              if(current is UpdateUserDataInitial){
                return true;
              }
              if(current is unAuthorized){
                return true;
              }
              if(current is update1){
                return true;
              }
              return false;
            }
        ),
      ),
    );
  }
}
