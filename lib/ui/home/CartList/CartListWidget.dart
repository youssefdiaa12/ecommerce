import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../Common/requiredLoginWidget.dart';
import '../../../di/di.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../Authentication/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'cartListCardWidget.dart';

class CartListWidget extends StatefulWidget {
  static const String routeName = 'CartListWidget';
  String ?perviousRoute;
   CartListWidget({this.perviousRoute});

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)?.settings.arguments as String;
    widget.perviousRoute=args;
    AppProvider provider1 = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
      //       Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pop(context);

            },

            icon: Icon(
              Icons.arrow_back,
              size: 28.sp,
              color: Color(0xff06004F),
            )),
        title: Text(
          "Product Details",
          style: TextStyle(
              color: Color(0xff06004F),
              fontWeight: FontWeight.w500,
              fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search_sharp, size: 28.sp, color: Color(0xff004182)),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.0.sp, right: 10.0.sp),
            child: badges.Badge(
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                position: badges.BadgePosition.topEnd(top: -14, end: -12),
                badgeStyle:
                    const badges.BadgeStyle(badgeColor: Color(0xff004182)),
                showBadge: true,
                badgeContent: Text(
                  (provider1.products_cartList?.length.toString() ?? "0"),
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                child: Image.asset("assets/icons/cart.png",
                    width: 25.w, height: 25.h)),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: BlocProvider(
          create: (context) => getIt<CartListViewModelCubit>()..invoke_getProductCartList(AppProvider.user?.token??""),
          child: BlocBuilder<CartListViewModelCubit, CartListViewModelState>(
            buildWhen: (previous, current) {
              if(current is CartListViewModelSuccess){
                setState(() {

                });
                return true;
              }
              if(current is CartListViewModelFailure){
                return true;
              }
              if(current is CartListViewModelLoading){
                return true;
              }
              if(current is unAuthorized){
                return true;
              }
              return false;
            },
              builder: (context, state) {
                if (state is CartListViewModelInitial) {
                  return Container();
                }
                if(state is CartListViewModelLoading){
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
                if(state is CartListViewModelFailure){
                  return Center(
                    child: Column(
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
                              var cubit = BlocProvider.of<CartListViewModelCubit>(context);
                              cubit.invoke_getProductCartList(AppProvider.user?.token ?? "");
                            },
                            child: const Text("Try again"))
                      ],
                    ),
                  );
                }
                if(state is CartListViewModelSuccess){
                  print("wooo");
                  print(state.products.length);
                  print(state.prices.length);
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
                      physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index==state.products.length-1? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          cartListCardWidget(state.products[index].product?.toProduct()??Product()
                              ,state.prices[index]??0,provider1.product_cartList_count![state.products[index].product!.id]??0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      children: [
                                        Text("Total Price",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(
                                            0xffb3b1c9)),),
                                        SizedBox(height: 5.h,),
                                        Text("${state.total} EGP",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(
                                            0xff004182)),),
                                      ]
                                  ),
                                  ElevatedButton(onPressed:()async{
                                    // var cubit = BlocProvider.of<CartListViewModelCubit>(context);
                                    // // await cubit.invoke_addToCart(
                                    // //     widget.product.id??"",
                                    // //     AppProvider.user?.token??"",
                                    // //     numberOfProducts);

                                  }, child:
                                  Row(
                                    children: [
                                      SizedBox(width: 10.w,),
                                      Text("Check out",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: Colors.white)),
                                      SizedBox(width: 45.w,),
                                      Icon(Icons.arrow_forward,color: Colors.white,),
                                    ],
                                  ),style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff004182),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )
                                  ))
                                ]
                            ),
                          )
                        ],
                      ):cartListCardWidget(state.products[index].product?.toProduct()??Product(),
                          state.prices[index]??0,provider1.product_cartList_count![state.products[index].product!.id]??0);
                    },
                    itemCount: state.products.length,
                  );
                }


            return Container();
          },

          )

      ),
    );
  }
}
