import 'package:ecommerce/ui/home/homeSuccssesTap/homeAdv.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../di/di.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';
import '../homeLoadingTap/homeBrandLoadingWidget.dart';
import '../homeLoadingTap/homeCategoryLoadingWidget.dart';
import '../homeLoadingTap/homeProductWidget.dart';
import 'homeBrandWidget.dart';
import 'homeProductWidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';

import 'home_all_brands/home_all_brands.dart';
import 'home_all_categories/home_all_categories.dart';
import 'home_all_products/home_all_products.dart';

class homeTap extends StatefulWidget {
  const homeTap({Key? key}) : super(key: key);

  @override
  State<homeTap> createState() => _homeTapState();
}

class _homeTapState extends State<homeTap> {
  static const _pageSize = 20;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);

  Future<void> fetchPage(int pageKey,int _pageSize,  HomeTapViewModelCubit cubit) async {
    try {
     cubit.getData(pageKey, _pageSize);
      final newItems = cubit.products;
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
      body: BlocProvider(
  create: (context) => getIt<HomeTapViewModelCubit>()..getData(1, 20),
  child: BlocConsumer<HomeTapViewModelCubit, HomeTapViewModelState>(
          buildWhen: (previous, current) {
            if (current is HomeTapViewModelSuccessful) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is HomeTapViewModelError) {
              dialogUtilites.lottieError(context, state.error);
            }
            if(state is unAuthorized){
              dialogUtilites.lottieLogin(context, "Please Login First");
            }
          },
          builder: (context, state) {
            if (state is HomeTapViewModelSuccessful) {
              var cubit = BlocProvider.of<HomeTapViewModelCubit>(context);
              print("products length ${cubit.products.length}");
              _pagingController.addPageRequestListener((pageKey) {
                fetchPage(pageKey, _pageSize, cubit);
              });
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: homeAdv(),
                    ),

                    //     PagedListView<int, Brand>(
                    //       pagingController: _pagingController,
                    //       builderDelegate: PagedChildBuilderDelegate<Brand>(
                    //       itemBuilder: (context, item, index) => (
                    //       homeBrandWidget(item)
                    //   ),
                    // ),
                    // ),
                    SliverToBoxAdapter(
                      child: SizedBox.fromSize(
                        size: Size.fromHeight(
                            MediaQuery.of(context).size.height * 0.35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style:
                                        Theme.of(context).textTheme.displayMedium,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        PersistentNavBarNavigator.pushNewScreen(context, screen: home_all_categories(state.categories),
                                            withNavBar:true);

                                      },
                                      child: Text(
                                        "View All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  return homeCategoryWidget(
                                      state.categories[index]);
                                },
                                itemCount: state.categories.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Brands",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            PersistentNavBarNavigator.pushNewScreen(context, screen: home_all_brands(state.brands),
                                                withNavBar:true);
                                          },
                                          child: Text(
                                            "View All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemBuilder: (context, index) {
                                      return homeBrandWidget(state.brands[index]);
                                    },
                                    itemCount: state.brands.length,
                                  ),
                                ),
                              ],
                            ))),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Most selling",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          PersistentNavBarNavigator.pushNewScreen(context, screen: home_all_products(state.products),
                                              withNavBar:true);

                                        },
                                        child: Text(
                                          "View All",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ))
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child:PagedListView<int, Product>(
                                      pagingController: _pagingController,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      builderDelegate: PagedChildBuilderDelegate<Product>(
                                        itemBuilder: (context, item, index) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: (
                                              homeProuctWidget(item)
                                          ),
                                        ),
                                      ),
                                    ),

                                    // GridView.builder(
                                    //   scrollDirection: Axis.horizontal,
                                    //   gridDelegate:
                                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                                    //     crossAxisCount: 1,
                                    //     mainAxisSpacing: 10,
                                    //     crossAxisSpacing: 10,
                                    //     childAspectRatio: 1.2,
                                    //   ),
                                    //   itemBuilder: (context, index) {
                                    //     return homeProuctWidget(
                                    //         state.products[index]);
                                    //   },
                                    //   itemCount: state.products.length,
                                    // ),
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
            if (state is HomeTapViewModelLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox.fromSize(
                        size: Size.fromHeight(
                             MediaQuery.of(context).size.height * 0.30,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )
                                  ),
                                  height: 180.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //     PagedListView<int, Brand>(
                    //       pagingController: _pagingController,
                    //       builderDelegate: PagedChildBuilderDelegate<Brand>(
                    //       itemBuilder: (context, item, index) => (
                    //       homeBrandWidget(item)
                    //   ),
                    // ),
                    // ),
                    SliverToBoxAdapter(
                      child: SizedBox.fromSize(
                        size: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style:
                                        Theme.of(context).textTheme.displayMedium,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "View All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: homeCategoryLoadingWidget());
                                },
                                itemCount: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Brands",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View All",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: homeBrandLoadingWidget());
                                    },
                                    itemCount: 8,
                                  ),
                                ),
                              ],
                            ))),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Most selling",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "View All",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ))
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                           SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                             childAspectRatio: 0.75.sp,
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
),
    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
