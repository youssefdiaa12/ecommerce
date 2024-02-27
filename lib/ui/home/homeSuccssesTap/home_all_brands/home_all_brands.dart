import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/Brand.dart';
import '../../homeLoadingTap/home_brand_loading_widget.dart';
import '../home_brand_widget.dart';

class HomeAllBrands extends StatefulWidget {
  List<Brand> brands;
  HomeAllBrands(this.brands, {super.key});
  @override
  State<HomeAllBrands> createState() => _HomeAllBrandsState();
}

class _HomeAllBrandsState extends State<HomeAllBrands> {
  @override
  Widget build(BuildContext context) {
    return widget.brands.isEmpty?const Center(
      child: HomeBrandLoadingWidget(),
    ):
        Scaffold(
          body: GridView.builder(
            physics:const BouncingScrollPhysics(),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ), itemBuilder:(context, index) {
            return Container(
              padding:EdgeInsets.symmetric(vertical: 25.h,horizontal:10.w),
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(25),
                  border:Border.all(color: const Color(0xffb2c5d9), width: 1),
                ),
                child: HomeBrandWidget(widget.brands[index]));
          },
          itemCount: widget.brands.length,
          ),
        );
  }
}
