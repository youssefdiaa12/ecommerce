// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';
import '../CategoriesTap/productDetailsCartWidget.dart';

class homeProuctWidget extends StatefulWidget {
  Product product;

  homeProuctWidget(this.product, {super.key});

  @override
  State<homeProuctWidget> createState() => _homeProuctWidgetState();
}

class _homeProuctWidgetState extends State<homeProuctWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider api_Provider = Provider.of<AppProvider>(context);
    var cubit = BlocProvider.of<HomeTapViewModelCubit>(context);

    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(context, screen: productDetailsCartWidget(widget.product),
            withNavBar:false
        );
      },
      child: Container(
        width: 250.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xff06004F), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 128.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            )),
                      );
                    },
                    imageUrl: widget.product.imageCover ?? ""),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent),
                  child: api_Provider.isFavorite(widget.product.id ?? "")
                      ? InkWell(
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context).primaryColor,
                                content: Row(
                                  children: [
                                    Text("Loading ...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 18.sp,
                                        )),
                                    const Spacer(),
                                    Icon(
                                      Icons.heart_broken_sharp,
                                      color: Colors.white,
                                      size: 20.sp,
                                    )
                                  ],
                                )));

                            String result = await api_Provider
                                .removeFromFavorite(widget.product.id ?? "");
                            if (result != "success") {
                              dialogUtilites.lottieError(
                                  context, "some thing went wrong");
                            } else {

                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  content: Row(
                                    children: [
                                      Text("Removed from favorites",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 18.sp,
                                          )),
                                      const Spacer(),
                                      Icon(
                                        Icons.heart_broken_sharp,
                                        color: Colors.white,
                                        size: 20.sp,
                                      )
                                    ],
                                  ),
                                ),
                              );

                              if (mounted) {
                                setState(() {
                                  // Your state update logic here
                                });
                              }
                            }
                          },
                          child: Image.asset(
                            "assets/icons/loved.png",
                            fit: BoxFit.contain,
                            width: 50.w,
                            height: 50.h,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                          bool is_logged= await cubit.checkAuthority();
                          if(!is_logged){
                            return;
                          }

                            String result = await api_Provider
                                .addToFavorite(widget.product.id ?? "");
                            if (result != "success") {
                              dialogUtilites.lottieError(
                                  context, "some thing went wrong");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  content: Row(
                                    children: [
                                      Text("Added to favorites",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 18.sp,
                                          )),
                                      const Spacer(),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 20.sp,
                                      )
                                    ],
                                  ),
                                ),
                              );
                              if (mounted) {
                                setState(
                                  () {
                                    print("added to favorites");
                                    // Your state update logic here
                                  },
                                );
                              }
                            }
                          },
                          child: Image.asset(
                            "assets/icons/unloved.png",
                            fit: BoxFit.contain,
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Text(
                widget.product.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Row(children: [
                const Text("EGP"),
                Padding(
                  padding:  EdgeInsets.only(left: 2.0.w),
                  child: Text(widget.product.price.toString() ?? ""),
                ),
              ]),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text("Review(${widget.product.ratingsAverage ?? ""})",
                        style:  TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          color: Color(0xff06004F),
                        )),
                     Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20.sp,
                      weight: 100.w,
                    ),
                  ]),
                   Padding(
                    padding: EdgeInsets.all(4.0.sp),
                    child: Icon(
                      Icons.add_circle_sharp,
                      color: Color(0xff004182),
                      size: 40.sp,
                      weight: 100,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
