import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/Common/requiredLoginWidget.dart';
import 'package:ecommerce/ui/home/lovedTap/wishListCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../di/di.dart';
import '../../../viewModel/LovedTapViewModel/loved_tap_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../Authentication/LoginScreen.dart';

class lovedTap extends StatefulWidget {
  const lovedTap({Key? key}) : super(key: key);

  @override
  State<lovedTap> createState() => _lovedTapState();
}

class _lovedTapState extends State<lovedTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LovedTapCubit>()
        ..getLovedProductList(AppProvider.user?.token ?? ""),
      child: BlocBuilder<LovedTapCubit, LovedTapState>(
        buildWhen: (previous, current) {
          if (current is ErrorLovedTapState) {
            return true;
          }
          if (current is AuthenticatedTapState) {
            return true;
          }
          if (current is UnAuthenticatedTapState) {
            return true;
          }
          if (current is SuccessLovedTapState) {
            return true;
          }
          if (current is LoadingLovedTapState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is UnAuthenticatedTapState) {
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
          if (state is AuthenticatedTapState) {
            return const Center();
          }
          if (state is ErrorLovedTapState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/error.json",
                    fit: BoxFit.cover,
                    height: 180.h,
                    width: 180.w,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  const Text(
                    "Something went wrong",
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextButton(
                      onPressed: () {
                        var cubit = BlocProvider.of<LovedTapCubit>(context);
                        cubit.getLovedProductList(AppProvider.user?.token ?? "");
                      },
                      child: const Text("Try again"))
                ],
              ),
            );
          }
          if (state is LoadingLovedTapState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/loading.json",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text("loading please wait...",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Poppins",
                        color: Color(0xff252065),
                      ))
                ],
              ),
            );
          }
          if (state is SuccessLovedTapState) {
            return state.products.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/animations/empty.json",
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Your loved list is empty",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: "Poppins",
                            color: Color(0xff252065),
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return wishListCardWidget(state.products[index]);
                    },
                    itemCount: state.products.length,
                  );
          }

          return Container();
        },
      ),
    );
  }
}
