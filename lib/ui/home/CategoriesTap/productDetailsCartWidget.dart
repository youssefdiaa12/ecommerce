import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productDetailsCartBodyWidget.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';

class productDetailsCartWidget extends StatefulWidget {
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
              padding: const EdgeInsets.only(right: 1.0, left: 6),
              child:
                  Image.asset("assets/icons/cart.png", width: 25.w, height: 25.h),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => getIt<CartListViewModelCubit>(),
          child: BlocListener<CartListViewModelCubit, CartListViewModelState>(
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
            child: productDetailsCartBodyWidget(widget.product),
        ),
        ),
      ),
    );
  }
}
