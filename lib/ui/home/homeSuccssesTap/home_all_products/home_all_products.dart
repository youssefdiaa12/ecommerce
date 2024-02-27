import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/ui/home/homeLoadingTap/home_product_widget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/home_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';

class HomeAllProducts extends StatefulWidget {
  List<Product> products = [];

  HomeAllProducts(this.products, {super.key});

  @override
  State<HomeAllProducts> createState() => _HomeAllProductsState();
}

class _HomeAllProductsState extends State<HomeAllProducts> {
  @override
  Widget build(BuildContext context) {

    return widget.products.isEmpty ? const Center(
      child: HomeProuctLoadingWidget(),
    ) :
    Scaffold(
      body: BlocProvider(

        create: (context) =>getIt<HomeTapViewModelCubit>(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 4.w),
          child: GridView.builder(
            physics:const BouncingScrollPhysics(),
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio:0.65
            ), itemBuilder: (context, index) {
            return HomeProuctWidget(widget.products[index]);
          },
            itemCount: widget.products.length,
          ),
        ),
      ),
    );
  }
}
