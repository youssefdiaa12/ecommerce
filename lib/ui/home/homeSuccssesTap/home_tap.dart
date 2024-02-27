import 'package:ecommerce/ui/home/homeSuccssesTap/home_adv.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/home_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Common/CustomAppBar.dart';
import '../../../di/di.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';
import '../homeLoadingTap/home_brand_loading_widget.dart';
import '../homeLoadingTap/home_category_loading_widget.dart';
import '../homeLoadingTap/home_product_widget.dart';
import 'home_brand_widget.dart';
import 'home_product_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'home_all_brands/home_all_brands.dart';
import 'home_all_categories/home_all_categories.dart';
import 'home_all_products/home_all_products.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({Key? key}) : super(key: key);

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  static const _pageSize = 20;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);
  Future<void> fetchPage(int pageKey,int pageSize,  HomeTapViewModelCubit cubit) async {
    try {
      cubit.getData(pageKey, pageSize);
      final newItems = cubit.products;
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        if(newItems==_pagingController.value.itemList){
return;
        }
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    AppProvider provider1 = Provider.of<AppProvider>(context);
    String productList=provider1.products_cartList?.length.toString()??"0";

    if(productList.length>=3){
      productList="99+";
    }
    return BlocProvider(
          create: (context) => getIt<HomeTapViewModelCubit>()..getData(0,  _pageSize),
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
                  _pagingController.addPageRequestListener((pageKey)async {
                    await fetchPage(pageKey, _pageSize, cubit);
                  });
                  return Scaffold(
                    appBar:CustomAppBar(),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: HomeAdv(),
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
                                              PersistentNavBarNavigator.pushNewScreen(context, screen: HomeAllCategories(state.categories),
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
                                        childAspectRatio: 0.9,
                                      ),
                                      itemBuilder: (context, index) {
                                        return HomeCategoryWidget(
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
                                                  PersistentNavBarNavigator.pushNewScreen(context, screen: HomeAllBrands(state.brands),
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
                                            return HomeBrandWidget(state.brands[index]);
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
                                                PersistentNavBarNavigator.pushNewScreen(context, screen: HomeAllProducts(state.products),
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
                                            physics: const BouncingScrollPhysics(),
                                            builderDelegate: PagedChildBuilderDelegate<Product>(
                                              itemBuilder: (context, item, index) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                child: (
                                                    HomeProuctWidget(item)
                                                ),
                                              ),
                                            ),
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
                    ),
                  );
                }
                if (state is HomeTapViewModelLoading) {
                  return Scaffold(
                    appBar:CustomAppBar(),
                    body: Padding(
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
                                            child: const HomeCategoryLoadingWidget());
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
                                                child: const HomeBrandLoadingWidget());
                                          },
                                          itemCount: 8,
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
                                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                                   childAspectRatio: 1.2,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade100,
                                                  child: const HomeProuctLoadingWidget());
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
                    ),
                  );
                }
                return Scaffold(
                  appBar:CustomAppBar(),
                  body: Padding(
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
                                          child: const HomeCategoryLoadingWidget());
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
                                              child: const HomeBrandLoadingWidget());
                                        },
                                        itemCount: 8,
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
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 1.2,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                child: const HomeProuctLoadingWidget());
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
                  ),
                );
              }),

);
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
