import 'package:ecommerce/domain/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../di/di.dart';
import '../../../viewModel/productsViewModelForCategory/category_products_cubit.dart';
import '../homeLoadingTap/homeProductWidget.dart';
import '../homeSuccssesTap/homeProductWidget.dart';

class categorProductsWidget extends StatefulWidget {
static const String routeName="categoriesProductsWidget";
const categorProductsWidget({super.key});
  @override
  State<categorProductsWidget> createState() => _categorProductsWidgetState();
}

class _categorProductsWidgetState extends State<categorProductsWidget> {

  CategoryProductsCubit cubit = getIt<CategoryProductsCubit>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var category = ModalRoute.of(context)!.settings.arguments as Category?;
     cubit.getData(category: category);
    return Scaffold(

      body: BlocConsumer<CategoryProductsCubit, CategoryProductsState>(
          bloc: cubit,
          buildWhen: (previous, current) {
            if (current is CategoryProductsSuccessful) {
              return true;
            }
            if (current is CategoryProductsError) {
              return true;
            }
            if(current is CategoryProductsLoading){
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is CategoryProductsError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.message),
                    );
                  });
            }
          },
          builder: (context, state) {
            if (state is CategoryProductsSuccessful) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                    ),
                                    child:

                                    GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.65,
                                      ),
                                      itemBuilder: (context, index) {
                                        return homeProuctWidget(
                                            state.products[index]);
                                      },
                                      itemCount: state.products.length,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 215.h,
                                )
                              ],
                            ))),
                  ],
                ),
              );
            }
            if (state is CategoryProductsLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 1.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            child: homeProuctLoadingWidget());
                                      },
                                      itemCount: 8,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 10.h,
                                )
                              ],
                            ))),
                  ],
                ),
              );
            }
            return Container();
          }),

    );
  }
}
