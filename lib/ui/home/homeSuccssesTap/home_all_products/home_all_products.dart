import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/ui/home/homeLoadingTap/homeProductWidget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';

class home_all_products extends StatefulWidget {
  List<Product> products = [];

  home_all_products(this.products);

  @override
  State<home_all_products> createState() => _home_all_productsState();
}

class _home_all_productsState extends State<home_all_products> {
  @override
  Widget build(BuildContext context) {

    return widget.products.isEmpty ? Center(
      child: homeProuctLoadingWidget(),
    ) :
    Scaffold(
      body: BlocProvider(

        create: (context) =>getIt<HomeTapViewModelCubit>(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 4.w),
          child: GridView.builder(
            physics:BouncingScrollPhysics(),
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio:0.85.sp
            ), itemBuilder: (context, index) {
            return homeProuctWidget(widget.products[index]);
          },
            itemCount: widget.products.length,
          ),
        ),
      ),
    );
  }
}
