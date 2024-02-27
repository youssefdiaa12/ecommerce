import 'package:ecommerce/ui/home/homeLoadingTap/home_category_loading_widget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/home_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/Category.dart';

class HomeAllCategories extends StatefulWidget {
  List<Category> categories=[];
  HomeAllCategories(this.categories, {super.key});
  @override
  State<HomeAllCategories> createState() => _HomeAllCategoriesState();
}

class _HomeAllCategoriesState extends State<HomeAllCategories> {
  @override
  Widget build(BuildContext context) {
         return widget.categories.isEmpty?const Center(
      child: HomeCategoryLoadingWidget(),
    ):
    Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 10.0.h),
        child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ), itemBuilder:(context, index) {
          return HomeCategoryWidget(widget.categories[index]);
        },
          itemCount: widget.categories.length,
        ),
      ),
    );
  }
  }

