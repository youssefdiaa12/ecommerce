import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productDetailsCartBodyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import 'package:badges/badges.dart' as badges;

import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../CartList/CartListWidget.dart';
import 'package:provider/provider.dart';

class productDetailsCartWidget extends StatefulWidget {
  static const String routeName = 'productDetailsCartWidget';
final  Product product;
bool is_read_more=false;
int size_selectedIndex=0,color_selectedIndex=0;
List <Color> colors=[Colors.red,Colors.green,Colors.blue,Colors.orangeAccent];

  productDetailsCartWidget(this.product);

  @override
  State<productDetailsCartWidget> createState() =>
      _productDetailsCartWidgetState();
}

class _productDetailsCartWidgetState extends State<productDetailsCartWidget> {
  CarouselController buttonCarouselController = CarouselController();
  int currentPage = 0;
  int numberOfProducts=1;

  @override
  Widget build(BuildContext context) {
    AppProvider provider1 = Provider.of<AppProvider>(context);
    String productList=provider1.products_cartList?.length.toString()??"0";
    if(productList.length>=3){
      productList="99+";
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
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
            Row(
              children: [
                Icon(Icons.search_sharp, size: 28.sp, color: Color(0xff004182)),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,CartListWidget.routeName,
                        arguments:"ssss");
                    // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    //   context,
                    //   screen:CartListWidget(),
                    //   withNavBar: false,
                    //   settings: RouteSettings(name:"sss"),
                    // );
                  },
                  child: badges.Badge(
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      position: badges.BadgePosition.topEnd(top: -14, end: -14),
                      badgeStyle: const badges.BadgeStyle(badgeColor: Color(0xff004182)),
                      showBadge: true,

                      badgeContent: Text((productList) ,style: TextStyle(color: Colors.white,
                          fontSize:14.sp
                      ),

                      ),
                      child: Image.asset("assets/icons/cart.png", width: 25.w, height: 25.h)),
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),

          ],
        ),
        body: BlocProvider(
          create: (context) => getIt<CartListViewModelCubit>(),
          child: BlocConsumer<CartListViewModelCubit, CartListViewModelState>(
            listener: (context, state) {
              if (state is CartListViewModelSuccess) {
                Navigator.pop(dialogUtilites.dialogContext!);
                Fluttertoast.showToast(
                  msg: "Added to cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xff004182),
                  textColor: Colors.white,
                );}
              if (state is CartListViewModelFailure) {
                   Navigator.pop(dialogUtilites.dialogContext!);
                dialogUtilites.lottieError(context, "something went wrong");
              }
              if (state is CartListViewModelLoading) {
                dialogUtilites.lottieLoading(context, "Loading...");
              }
              if (state is unAuthorized) {
                dialogUtilites.lottieLogin(context, "please login first");
              }
            },
            listenWhen: (previous, current) {
              if (current is CartListViewModelSuccess) {
                return true;
              }
              if (current is CartListViewModelFailure) {
                return true;
              }
              if (current is CartListViewModelLoading) {
                return true;
              }
              if (current is unAuthorized) {
                return true;
              }
              return false;
            },
            builder:(context, state) {
              if(state is CartListViewModelSuccess){
                return ProductDetailsCartBodyWidget(widget.product);
              }
                return ProductDetailsCartBodyWidget(widget.product);
            },
            buildWhen: (previous, current) {
              if (current is CartListViewModelSuccess) {
                setState(() {

                });
                return true;
              }
              if(current is CartListViewModelInitial){
                setState(() {

                });
                return true;
              }
              return false;
            }
        ),
        ),
      ),
    );
  }
}
