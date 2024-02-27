// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../Common/flash_bar.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/homeTapViewModel/home_tap_view_model_cubit.dart';
import '../CategoriesTap/productDetailsCartWidget.dart';

class HomeProuctWidget extends StatefulWidget {
  final Product product;

  const HomeProuctWidget(this.product, {super.key});

  @override
  State<HomeProuctWidget> createState() => _HomeProuctWidgetState();
}

class _HomeProuctWidgetState extends State<HomeProuctWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider apiProvider = Provider.of<AppProvider>(context);
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 250.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
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
                  child: apiProvider.isFavorite(widget.product.id ?? "")
                      ? InkWell(
                          onTap: () async {
                            String result = await apiProvider
                                .removeFromFavorite(widget.product.id ?? "");
                            if (result != "success") {
                              dialogUtilites.lottieError(
                                  context, "some thing went wrong");
                            } else {
                              showFlushBar("Removed From Favorite",context,isError:true);
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
                          bool isLogged= await cubit.checkAuthority();
                          if(!isLogged){return;}
                          String result = await apiProvider
                                .addToFavorite(widget.product.id ?? "");
                            if (result != "success") {
                              dialogUtilites.lottieError(
                                  context, "some thing went wrong");
                            } else {
                              showFlushBar("Added to favorites",context,isError:false);
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
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 4.0.w),
                          child: Text(widget.product.price.toString()),
                        ),
                        const Text("EGP"),

                      ],
                    ),
                Row(children: [
                  Text("Review(${widget.product.ratingsAverage ?? ""})",
                      style:  TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: const Color(0xff06004F),
                      )),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20.sp,
                    weight: 100.w,
                  ),
                ])
              ]),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }
}
