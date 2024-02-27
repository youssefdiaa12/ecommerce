import 'package:ecommerce/Common/requiredLoginWidget.dart';
import 'package:ecommerce/ui/home/lovedTap/wish_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../Common/CustomAppBar.dart';
import '../../../di/di.dart';
import '../../../viewModel/LovedTapViewModel/loved_tap_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../Authentication/LoginScreen.dart';

class LovedTap extends StatefulWidget {
  const LovedTap({Key? key}) : super(key: key);

  @override
  State<LovedTap> createState() => _LovedTapState();
}

class _LovedTapState extends State<LovedTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocProvider(
          create: (context) => getIt<LovedTapCubit>()..getLovedProductList(AppProvider.user?.token ?? ""),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                    requiredLoginWidget(
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
                    ),
                  ],
                );
              }
              if (state is AuthenticatedTapState) {
                return const Center();
              }
              if (state is ErrorLovedTapState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.2,),
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

                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                      Lottie.asset(
                        "assets/animations/loading.json",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("loading please wait...",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "Poppins",
                            color: const Color(0xff252065),
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
                                color: const Color(0xff252065),
                              ),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return WishListCardWidget(state.products[index]);
                        },
                        itemCount: state.products.length,
                      );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
