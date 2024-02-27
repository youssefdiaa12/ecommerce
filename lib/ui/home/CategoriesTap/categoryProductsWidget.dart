import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/domain/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../di/di.dart';
import '../../../viewModel/productsViewModelForCategory/category_products_cubit.dart';
import '../homeLoadingTap/home_product_widget.dart';
import 'categoryProuctListWidget.dart';

class CategorProductsWidget extends StatefulWidget {
static const String routeName="categoriesProductsWidget";
const CategorProductsWidget({super.key});
  @override
  State<CategorProductsWidget> createState() => _CategorProductsWidgetState();
}

class _CategorProductsWidgetState extends State<CategorProductsWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var category = ModalRoute.of(context)!.settings.arguments as Category?;
    return Scaffold(

      body: BlocProvider(
  create: (context) => getIt<CategoryProductsCubit>()..getData(category: category),
  child: BlocConsumer<CategoryProductsCubit, CategoryProductsState>(
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
            if(state is unAuthorized1){
              dialogUtilites.lottieLogin(context, "Please Login First");
            }

          },
          builder: (context, state) {
            if (state is CategoryProductsSuccessful) {
              return state.products.length!=0?Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        child:
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics:const BouncingScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.55,
                          ),
                          itemBuilder: (context, index) {
                            return CategoryProuctListWidget(
                                state.products[index]);
                          },
                          itemCount: state.products.length,
                        ),
                      ),
                    ),
                  ],
                )
              ):
              Center(
                child: Text("No Products Found",
                style: Theme.of(context).textTheme.titleMedium,),
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
                                            child: HomeProuctLoadingWidget());
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
),

    );
  }
}
